#!/usr/bin/env ruby
# scripts/screenshot_generator/generate_screenshots.rb
# frozen_string_literal: true

require 'erb'
require 'fileutils'

# Configuration
TMUX_CONFIG = File.expand_path('~/dotfiles/tmux/.tmux.conf')
TMUX_CONFIG_BACKUP = "#{TMUX_CONFIG}.backup"
PROJECT_ROOT = File.expand_path('../..', __dir__)
TEMPLATE_DIR = File.join(PROJECT_ROOT, 'scripts/screenshot_generator')
OUTPUT_DIR = File.join(PROJECT_ROOT, 'assets/screenshots')
TEMP_DIR = '/tmp'

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

# Screenshot dimensions match existing assets/screenshots/ (full terminal size)
# Note: Cropped versions for social media are created separately in assets/socials/

class ScreenshotGenerator
  def initialize
    @errors = []
  end

  def run
    check_dependencies
    backup_tmux_config
    generate_all_screenshots
    restore_tmux_config
    report_results
  end

  private

  def check_dependencies
    puts 'Checking dependencies...'

    required_commands = %w[vhs tmux]
    missing = required_commands.reject { |cmd| system("which #{cmd} > /dev/null 2>&1") }

    if missing.any?
      puts "Missing required commands: #{missing.join(', ')}"
      puts '   Install with:'
      puts '   - vhs: https://github.com/charmbracelet/vhs'
      puts '   - tmux: your package manager'
      exit 1
    end

    unless File.exist?(TMUX_CONFIG)
      puts "tmux config not found at: #{TMUX_CONFIG}"
      exit 1
    end

    puts 'All dependencies found'
  end

  def backup_tmux_config
    puts "\n Backing up tmux config..."
    FileUtils.cp(TMUX_CONFIG, TMUX_CONFIG_BACKUP)
    puts "Backup created at: #{TMUX_CONFIG_BACKUP}"
  end

  def restore_tmux_config
    puts "\n Restoring original tmux config..."
    FileUtils.mv(TMUX_CONFIG_BACKUP, TMUX_CONFIG)
    puts 'Config restored'
  end

  def generate_all_screenshots
    puts "\nGenerating screenshots for #{VARIANTS.count} variants..."
    puts '=' * 60

    VARIANTS.each_with_index do |variant, index|
      puts "\n[#{index + 1}/#{VARIANTS.count}] Processing: #{variant}"

      begin
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

    File.write(TMUX_CONFIG, updated)
    puts "  Updated tmux config to flavor: #{variant}"
  end

  def generate_variant_screenshots(variant)
    # Generate both screenshots in one tape (dashboard template now captures both)
    generate_screenshots_combined(variant)
  end

  def generate_screenshots_combined(variant)
    template_file = File.join(TEMPLATE_DIR, "tape-dashboard.tape.template")
    tape_file = File.join(TEMP_DIR, "oasis-#{variant}.tape")
    dashboard_screenshot = "oasis-#{variant}-dashboard.png"
    code_screenshot = "oasis-#{variant}-code.png"

    # Clean up any previous failed attempts (directories from VHS failures)
    [dashboard_screenshot, code_screenshot].each do |screenshot|
      temp_path = File.join(TEMP_DIR, screenshot)
      FileUtils.rm_rf(temp_path) if File.exist?(temp_path)
    end

    # Generate VHS tape from template
    template = ERB.new(File.read(template_file))
    tape_content = template.result_with_hash(variant: variant)
    File.write(tape_file, tape_content)

    puts "  Recording both screenshots with VHS..."
    # Run VHS from TEMP_DIR so output goes there
    Dir.chdir(TEMP_DIR) do
      raise "VHS recording failed for #{variant}" unless system("vhs #{tape_file}")
    end

    # Move both screenshots to final location (force overwrite if exists)
    [dashboard_screenshot, code_screenshot].each do |screenshot|
      source_file = File.join(TEMP_DIR, screenshot)
      final_file = File.join(OUTPUT_DIR, screenshot.sub('oasis-', ''))

      # Check if source file was actually created
      unless File.file?(source_file)
        raise "VHS did not create #{screenshot} - check tape file"
      end

      # Remove existing file/directory at destination
      FileUtils.rm_rf(final_file) if File.exist?(final_file)
      FileUtils.mv(source_file, final_file)
      puts "  Saved: #{final_file}"
    end

    # Cleanup tape file
    File.delete(tape_file) if File.exist?(tape_file)
  end

  def generate_screenshot(variant, type)
    template_file = File.join(TEMPLATE_DIR, "tape-#{type}.tape.template")
    tape_file = File.join(TEMP_DIR, "oasis-#{variant}-#{type}.tape")
    temp_screenshot = "oasis-#{variant}-#{type}.png"  # VHS outputs to current directory
    final_screenshot = File.join(OUTPUT_DIR, "#{variant}-#{type}.png")

    # Generate VHS tape from template
    template = ERB.new(File.read(template_file))
    tape_content = template.result_with_hash(variant: variant)
    File.write(tape_file, tape_content)

    puts "  Recording #{type} with VHS..."
    # Run VHS from TEMP_DIR so output goes there
    Dir.chdir(TEMP_DIR) do
      raise "VHS recording failed for #{variant} #{type}" unless system("vhs #{tape_file}")
    end

    # Move screenshot to final location (force overwrite if exists)
    source_file = File.join(TEMP_DIR, temp_screenshot)
    File.delete(final_screenshot) if File.exist?(final_screenshot)
    FileUtils.mv(source_file, final_screenshot)

    # Cleanup tape file
    File.delete(tape_file) if File.exist?(tape_file)

    puts "  Saved: #{final_screenshot}"
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
