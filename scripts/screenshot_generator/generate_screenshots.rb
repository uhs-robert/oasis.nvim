#!/usr/bin/env ruby
# scripts/screenshot_generator/generate_screenshots.rb
# frozen_string_literal: true

require 'fileutils'
require 'shellwords'

# Configuration
TMUX_CONFIG = File.expand_path('~/dotfiles/tmux/.tmux.conf')
TMUX_CONFIG_BACKUP = "#{TMUX_CONFIG}.backup"
PROJECT_ROOT = File.expand_path('../..', __dir__)
OUTPUT_DIR = File.join(PROJECT_ROOT, 'assets/screenshots')
TEMP_DIR = '/tmp/oasis-screenshots'
LIGHT_INTENSITY = 3

# Dual-mode themes (have both dark and light variants)
DUAL_MODE_THEMES = %w[
  night
  midnight
  abyss
  starlight
  desert
  sol
  canyon
  dune
  cactus
  mirage
  lagoon
  twilight
  rose
].freeze

# Special palettes that should capture all light intensity levels (1-5)
SPECIAL_LIGHT_INTENSITY_THEMES = {
  'lagoon' => (1..5).to_a
}.freeze

# Generate all variants (dual-mode get both dark and light)
VARIANTS = (
  DUAL_MODE_THEMES.flat_map { |theme| ["#{theme}_dark", "#{theme}_light_#{LIGHT_INTENSITY}"] } +
  SPECIAL_LIGHT_INTENSITY_THEMES.flat_map do |theme, intensities|
    intensities.map { |i| "#{theme}_light_#{i}" }
  end
).freeze

# Testing single variant
# VARIANTS = %w[canyon_dark canyon_light]

# Tmux configuration manager for screenshot generation
module TmuxConfigManager
  module_function

  def backup
    puts "\nBacking up tmux config..."
    FileUtils.cp(TMUX_CONFIG, TMUX_CONFIG_BACKUP)
    puts "Backup created at: #{TMUX_CONFIG_BACKUP}"
  end

  def restore
    puts "\nRestoring original tmux config..."
    FileUtils.mv(TMUX_CONFIG_BACKUP, TMUX_CONFIG)
    puts 'Config restored'
  end

  def kill_server
    puts '  Killing tmux server...'
    system('tmux kill-server 2>/dev/null || true')
    sleep 1
  end

  def update_flavor(variant)
    content = File.read(TMUX_CONFIG)
    # Match word characters and underscores for dual-mode variants (e.g., canyon_dark)
    updated = content.gsub(
      /set -g @oasis_flavor ["']?[\w_]+["']?/,
      "set -g @oasis_flavor \"#{variant}\""
    )

    warn_if_unchanged(updated, content)
    File.write(TMUX_CONFIG, updated)
    verify_update(variant)

    puts "  Updated tmux config to flavor: #{variant}"
  end

  def warn_if_unchanged(updated, original)
    return unless updated == original

    puts '  WARNING: tmux config was not modified - flavor line may not match regex'
  end

  def verify_update(variant)
    verify = File.read(TMUX_CONFIG)
    return if verify.include?("@oasis_flavor \"#{variant}\"")

    raise "Failed to update tmux config to #{variant}"
  end
end

# Variant screenshot workflow manager
class ScreenshotWorkflow
  def initialize(variant, screenshot_capture)
    @variant = variant
    @instance_name = "oasis-screenshot-#{variant}"
    @kitty = KittyController.new(@instance_name)
    @screenshot_capture = screenshot_capture

    # Parse variant to extract base name, mode, and optional light intensity
    # e.g., "canyon_dark" -> base="canyon", mode="dark", intensity=nil
    #       "lagoon_light_3" -> base="lagoon", mode="light", intensity=3
    #       "dawn" -> base="dawn", mode=nil, intensity=nil
    @base_name, @mode, @intensity = parse_variant(variant)
  end

  def run
    launch_terminal
    capture_dashboard
    capture_code_view
    close_terminal
  end

  private

  def parse_variant(variant)
    match = variant.match(/^(?<base>.+?)(?:_(?<mode>dark|light)(?:_(?<intensity>\d))?)?$/)
    base = match[:base]
    mode = match[:mode]
    intensity = match[:intensity]&.to_i
    [base, mode, intensity]
  end

  def launch_terminal
    puts '  Launching Kitty terminal...'
    @kitty.launch
  end

  def capture_dashboard
    puts '  Opening Neovim dashboard...'
    @kitty.send_keys("cd #{PROJECT_ROOT}")
    @kitty.send_keys('nvim')
    sleep 1
    # Run lua first, can't chain the pipe | with lua
    @kitty.send_keys(":lua local cfg=require('oasis.config').get(); cfg.light_intensity=#{@intensity}") if @intensity
    command_chain = ['set termguicolors']
    command_chain << "set background=#{@mode}" if @mode
    command_chain << "colorscheme oasis-#{@base_name}"
    @kitty.send_keys(":#{command_chain.join(' | ')}")
    @screenshot_capture.capture(@instance_name, @variant, 'dashboard')
  end

  def capture_code_view
    puts '  Opening code file...'
    @kitty.send_keys(':e assets/example-scripts/index.js')
    sleep 0.5
    @kitty.send_keys('')
    @kitty.send_keys("\e")
    @kitty.send_keys('19G')
    @kitty.send_keys('$')
    @screenshot_capture.capture(@instance_name, @variant, 'code')
  end

  def close_terminal
    puts '  Closing Kitty...'
    @kitty.close
  end
end

# Screenshot capture handler
class ScreenshotCapture
  def initialize(temp_dir, output_dir)
    @temp_dir = temp_dir
    @output_dir = output_dir
  end

  def capture(instance_name, variant, type)
    # Convert underscore to hyphen for filename (e.g., canyon_dark -> canyon-dark)
    filename_variant = variant.gsub('_', '-')
    temp_file = File.join(@temp_dir, "#{filename_variant}-#{type}.png")
    final_file = File.join(@output_dir, "#{filename_variant}-#{type}.png")

    puts "  Capturing #{type} screenshot..."
    focus_window(instance_name)
    take_screenshot(filename_variant, type, temp_file)
    move_to_final_location(temp_file, final_file)

    puts "  Saved: #{final_file}"
  end

  private

  def focus_window(instance_name)
    system("hyprctl dispatch focuswindow title:#{instance_name}")
    sleep 0.5
  end

  def take_screenshot(variant, type, temp_file)
    system("hyprshot -m window -m active -o #{@temp_dir} -f #{variant}-#{type}.png --silent 2>/dev/null")

    return if File.exist?(temp_file) && File.size(temp_file).positive?

    raise "hyprshot failed to capture #{variant} #{type} - file not created or empty"
  end

  def move_to_final_location(temp_file, final_file)
    FileUtils.rm_f(final_file) if File.exist?(final_file)
    FileUtils.mv(temp_file, final_file)
  end
end

# Dependency checker for screenshot generation
module DependencyChecker
  module_function

  def check_all
    puts 'Checking dependencies...'
    check_required_commands
    check_kitty_remote_control
    check_tmux_config
    puts 'All dependencies found'
  end

  def check_required_commands
    required_commands = %w[hyprshot kitty tmux]
    missing = required_commands.reject { |cmd| system("which #{cmd} > /dev/null 2>&1") }

    return unless missing.any?

    puts "Missing required commands: #{missing.join(', ')}"
    puts '  Install with:'
    puts '  - hyprshot: https://github.com/Gustash/Hyprshot'
    puts '  - kitty: your package manager'
    puts '  - tmux: your package manager'
    exit 1
  end

  def check_kitty_remote_control
    kitty_conf = File.expand_path('~/.config/kitty/kitty.conf')
    if File.exist?(kitty_conf)
      verify_kitty_config(kitty_conf)
    else
      warn_missing_kitty_config
    end
  end

  def verify_kitty_config(kitty_conf)
    content = File.read(kitty_conf)
    return if content.include?('allow_remote_control') && content =~ /allow_remote_control\s+(yes|socket-only)/

    puts 'Kitty remote control not enabled'
    puts '  Add to ~/.config/kitty/kitty.conf:'
    puts '    allow_remote_control yes'
    puts '  or:'
    puts '    allow_remote_control socket-only'
    exit 1
  end

  def warn_missing_kitty_config
    puts 'Warning: Could not find kitty.conf to verify remote control is enabled'
    puts '  Make sure you have "allow_remote_control yes" in your kitty config'
  end

  def check_tmux_config
    return if File.exist?(TMUX_CONFIG)

    puts "tmux config not found at: #{TMUX_CONFIG}"
    exit 1
  end
end

# Kitty terminal controller for screenshot generation
class KittyController
  def initialize(instance_name)
    @instance_name = instance_name
    @socket_path = "/tmp/kitty-#{instance_name}"
  end

  def launch
    File.delete(@socket_path) if File.exist?(@socket_path)

    spawn_instance
    attempts = wait_for_socket
    comm_attempts = wait_for_communication

    puts "  Kitty socket ready after #{(attempts * 0.5) + (comm_attempts * 0.5)}s"
  end

  def send_keys(text, enter: true)
    command = "kitten @ --to unix:#{@socket_path} send-text"
    payload = enter ? "#{text}\n" : text
    system("#{command} #{Shellwords.escape(payload)}")
    sleep 0.5
  end

  def close
    system("kitten @ --to unix:#{@socket_path} close-window --self")
    sleep 0.5
    File.delete(@socket_path) if File.exist?(@socket_path)
    sleep 0.5
  end

  private

  def spawn_instance
    pid = spawn(
      "kitty --title #{@instance_name} --name #{@instance_name} " \
      "-o allow_remote_control=yes --listen-on unix:#{@socket_path} " \
      "tmux -2 -f #{TMUX_CONFIG} new-session",
      %i[out err] => '/dev/null'
    )
    Process.detach(pid)
  end

  def wait_for_socket(max_attempts: 20)
    attempts = 0
    until File.exist?(@socket_path) || attempts >= max_attempts
      sleep 0.5
      attempts += 1
    end

    raise "Kitty socket not created after #{max_attempts * 0.5}s: #{@socket_path}" unless File.exist?(@socket_path)

    attempts
  end

  def wait_for_communication(max_attempts: 10)
    attempts = 0
    until attempts >= max_attempts
      return attempts if system("kitten @ --to unix:#{@socket_path} ls > /dev/null 2>&1")

      sleep 0.5
      attempts += 1
    end

    raise "Kitty not responding on socket after #{max_attempts * 0.5}s: #{@socket_path}"
  end
end

# Automated screenshot generator for Oasis.nvim colorscheme variants.
# Generates dashboard and code screenshots for all theme variants using
# Kitty terminal, tmux, and Neovim. Requires Hyprland window manager with
# hyprshot for screenshot capture because that's what I use personally.
class ScreenshotGenerator
  def initialize
    @errors = []
    @screenshot_capture = ScreenshotCapture.new(TEMP_DIR, OUTPUT_DIR)
  end

  def run
    DependencyChecker.check_all
    FileUtils.mkdir_p(TEMP_DIR)
    TmuxConfigManager.backup
    generate_all_screenshots
    TmuxConfigManager.restore
    FileUtils.rm_rf(TEMP_DIR) if File.exist?(TEMP_DIR)
    report_results
  end

  private

  def generate_all_screenshots
    puts "\nGenerating screenshots for #{VARIANTS.count} variants..."
    puts '=' * 60

    VARIANTS.each_with_index do |variant, index|
      puts "\n[#{index + 1}/#{VARIANTS.count}] Processing: #{variant}"
      process_variant(variant)
    end
  end

  def process_variant(variant)
    TmuxConfigManager.kill_server
    TmuxConfigManager.update_flavor(variant)
    ScreenshotWorkflow.new(variant, @screenshot_capture).run
    puts "#{variant} complete"
  rescue StandardError => e
    error_msg = "Failed to process #{variant}: #{e.message}"
    @errors << error_msg
    puts error_msg
  end

  def report_results
    puts "\n#{'=' * 60}"

    if @errors.empty?
      total_screenshots = VARIANTS.count * 2 # 2 screenshots per variant (dashboard + code)
      puts "SUCCESS! All #{total_screenshots} screenshots generated (#{VARIANTS.count} variants)"
      puts "Output directory: #{OUTPUT_DIR}"
    else
      puts "Completed with #{@errors.count} error(s):"
      @errors.each { |e| puts "   - #{e}" }
    end
  end
end

# Run the generator
if __FILE__ == $PROGRAM_NAME
  generator = ScreenshotGenerator.new
  generator.run
end
