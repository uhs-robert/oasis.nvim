#!/usr/bin/env ruby
# scripts/screenshot_generator/generate_screenshots.rb
# frozen_string_literal: true

require 'fileutils'

# Configuration
TMUX_CONFIG = File.expand_path('~/dotfiles/tmux/.tmux.conf')
TMUX_CONFIG_BACKUP = "#{TMUX_CONFIG}.backup"
PROJECT_ROOT = File.expand_path('../..', __dir__)
OUTPUT_DIR = File.join(PROJECT_ROOT, 'assets/screenshots')
TEMP_DIR = '/tmp/oasis-screenshots'

# All 18 variants in order (dark themes, then light themes)
VARIANTS = %w[
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
  dawn
  dawnlight
  day
  dusk
  dust
]

# Testing single variant
# VARIANTS = %w[canyon]

# Screenshot dimensions match existing assets/screenshots/ (full terminal size)
# Note: Cropped versions for social media are created separately in assets/socials/

class ScreenshotGenerator
  def initialize
    @errors = []
  end

  def run
    check_dependencies
    setup_temp_dir
    backup_tmux_config
    generate_all_screenshots
    restore_tmux_config
    cleanup_temp_dir
    report_results
  end

  private

  def check_dependencies
    puts 'Checking dependencies...'

    required_commands = %w[hyprshot kitty tmux]
    missing = required_commands.reject { |cmd| system("which #{cmd} > /dev/null 2>&1") }

    if missing.any?
      puts "Missing required commands: #{missing.join(', ')}"
      puts '  Install with:'
      puts '  - hyprshot: https://github.com/Gustash/Hyprshot'
      puts '  - kitty: your package manager'
      puts '  - tmux: your package manager'
      exit 1
    end

    # Check if kitty remote control is enabled
    kitty_conf = File.expand_path('~/.config/kitty/kitty.conf')
    if File.exist?(kitty_conf)
      content = File.read(kitty_conf)
      unless content.include?('allow_remote_control') && content =~ /allow_remote_control\s+(yes|socket-only)/
        puts 'Kitty remote control not enabled'
        puts '  Add to ~/.config/kitty/kitty.conf:'
        puts '    allow_remote_control yes'
        puts '  or:'
        puts '    allow_remote_control socket-only'
        exit 1
      end
    else
      puts 'Warning: Could not find kitty.conf to verify remote control is enabled'
      puts '  Make sure you have "allow_remote_control yes" in your kitty config'
    end

    unless File.exist?(TMUX_CONFIG)
      puts "tmux config not found at: #{TMUX_CONFIG}"
      exit 1
    end

    puts 'All dependencies found'
  end

  def setup_temp_dir
    FileUtils.mkdir_p(TEMP_DIR)
  end

  def cleanup_temp_dir
    FileUtils.rm_rf(TEMP_DIR) if File.exist?(TEMP_DIR)
  end

  def backup_tmux_config
    puts "\nBacking up tmux config..."
    FileUtils.cp(TMUX_CONFIG, TMUX_CONFIG_BACKUP)
    puts "Backup created at: #{TMUX_CONFIG_BACKUP}"
  end

  def restore_tmux_config
    puts "\nRestoring original tmux config..."
    FileUtils.mv(TMUX_CONFIG_BACKUP, TMUX_CONFIG)
    puts 'Config restored'
  end

  def kill_tmux
    puts '  Killing tmux server...'
    system('tmux kill-server 2>/dev/null || true')
    sleep 1
  end

  def generate_all_screenshots
    puts "\nGenerating screenshots for #{VARIANTS.count} variants..."
    puts '=' * 60

    VARIANTS.each_with_index do |variant, index|
      puts "\n[#{index + 1}/#{VARIANTS.count}] Processing: #{variant}"

      begin
        kill_tmux
        update_tmux_config(variant)
        generate_variant_screenshots(variant)
        puts "#{variant} complete"
      rescue StandardError => e
        error_msg = "Failed to process #{variant}: #{e.message}"
        @errors << error_msg
        puts "#{error_msg}"
      end
    end
  end

  def update_tmux_config(variant)
    content = File.read(TMUX_CONFIG)

    # Replace the @oasis_flavor line
    updated = content.gsub(
      /set -g @oasis_flavor ["']?\w+["']?/,
      "set -g @oasis_flavor \"#{variant}\""
    )

    puts '  WARNING: tmux config was not modified - flavor line may not match regex' if updated == content

    File.write(TMUX_CONFIG, updated)

    # Verify the change
    verify = File.read(TMUX_CONFIG)
    raise "Failed to update tmux config to #{variant}" unless verify.include?("@oasis_flavor \"#{variant}\"")

    puts "  Updated tmux config to flavor: #{variant}"
  end

  def generate_variant_screenshots(variant)
    kitty_instance = "oasis-screenshot-#{variant}"

    puts '  Launching Kitty terminal...'
    launch_kitty(kitty_instance)

    puts '  Opening Neovim dashboard...'
    open_nvim_dashboard(kitty_instance, variant)
    capture_screenshot(kitty_instance, variant, 'dashboard')

    puts '  Opening code file...'
    open_code_file(kitty_instance, variant)
    capture_screenshot(kitty_instance, variant, 'code')

    puts '  Closing Kitty...'
    close_kitty(kitty_instance)
  end

  def launch_kitty(instance_name)
    # Launch Kitty with tmux, using --title to identify the window
    # Hyprland will auto-size the window based on monitor/workspace rules
    socket_path = "/tmp/kitty-#{instance_name}"

    # Clean up any stale socket
    File.delete(socket_path) if File.exist?(socket_path)

    pid = spawn(
      "kitty --title #{instance_name} --name #{instance_name} " \
      "-o allow_remote_control=yes --listen-on unix:#{socket_path} " \
      "tmux -2 -f #{TMUX_CONFIG} new-session",
      %i[out err] => '/dev/null'
    )
    Process.detach(pid)

    # Wait for socket to be created (with timeout)
    max_attempts = 20 # 10 seconds total
    attempts = 0
    until File.exist?(socket_path) || attempts >= max_attempts
      sleep 0.5
      attempts += 1
    end

    raise "Kitty socket not created after #{max_attempts * 0.5}s: #{socket_path}" unless File.exist?(socket_path)

    # Verify we can communicate with kitty using kitten @ (not kitty @)
    max_comm_attempts = 10
    comm_attempts = 0
    until comm_attempts >= max_comm_attempts
      if system("kitten @ --to unix:#{socket_path} ls > /dev/null 2>&1")
        puts "  Kitty socket ready after #{(attempts * 0.5) + (comm_attempts * 0.5)}s"
        return
      end
      sleep 0.5
      comm_attempts += 1
    end

    raise "Kitty not responding on socket after #{(attempts + comm_attempts) * 0.5}s: #{socket_path}"
  end

  def send_keys(instance_name, text, enter: true)
    # Use kitten @ for remote control (correct syntax per Kitty documentation)
    command = "kitten @ --to unix:/tmp/kitty-#{instance_name} send-text"
    if enter
      system("#{command} '#{text}\n'")
    else
      system("#{command} --no-newline '#{text}'")
    end
    sleep 0.5 # Small delay between commands
  end

  def open_nvim_dashboard(instance_name, variant)
    # Navigate to project directory and launch nvim with colorscheme
    send_keys(instance_name, "cd #{PROJECT_ROOT}")
    send_keys(instance_name, 'nvim')
    sleep 1
    send_keys(instance_name, ":set termguicolors | colorscheme oasis-#{variant}")
  end

  def open_code_file(instance_name, _variant)
    # Open the example code file
    send_keys(instance_name, ':e assets/example-scripts/index.js')
    sleep 0.5 # Give time for file to load and potential swap warnings
    # Clear any prompts by pressing Enter a few times
    send_keys(instance_name, '')
    # Navigate to line 19 and move to end of line
    send_keys(instance_name, "\e") # Escape to ensure normal mode
    send_keys(instance_name, '19G')  # Go to line 19
    send_keys(instance_name, '$')    # Move to end of line
  end

  def capture_screenshot(instance_name, variant, type)
    temp_file = File.join(TEMP_DIR, "#{variant}-#{type}.png")
    final_file = File.join(OUTPUT_DIR, "#{variant}-#{type}.png")

    puts "  Capturing #{type} screenshot..."

    # Focus the window first
    system("hyprctl dispatch focuswindow title:#{instance_name}")
    sleep 0.5

    # Capture active window non-interactively using -m window -m active
    # Note: hyprshot may return exit code 1 even on success, so we check file creation instead
    system("hyprshot -m window -m active -o #{TEMP_DIR} -f #{variant}-#{type}.png --silent 2>/dev/null")

    # Verify the screenshot was actually captured
    unless File.exist?(temp_file) && File.size(temp_file) > 0
      raise "hyprshot failed to capture #{variant} #{type} - file not created or empty"
    end

    # Move to final location
    FileUtils.rm_f(final_file) if File.exist?(final_file)
    FileUtils.mv(temp_file, final_file)
    puts "  Saved: #{final_file}"
  end

  def close_kitty(instance_name)
    # Close kitty instance gracefully using kitten @
    system("kitten @ --to unix:/tmp/kitty-#{instance_name} close-window --self")
    sleep 0.5
    # Cleanup socket
    socket_path = "/tmp/kitty-#{instance_name}"
    File.delete(socket_path) if File.exist?(socket_path)
    sleep 0.5
  end

  def report_results
    puts "\n" + '=' * 60

    if @errors.empty?
      puts "SUCCESS! All #{VARIANTS.count * 2} screenshots generated"
      puts "Output directory: #{OUTPUT_DIR}"
    else
      puts "Completed with #{@errors.count} error(s):"
      @errors.each { |e| puts "   - #{e}" }
    end
  end
end

# Run the generator
if __FILE__ == $0
  generator = ScreenshotGenerator.new
  generator.run
end
