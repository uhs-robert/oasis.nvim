#!/usr/bin/env ruby
# frozen_string_literal: true

require 'erb'
require 'json'
require 'optparse'
require 'fileutils'

# Oasis Vimium-C Theme Generator
# Generates custom Vimium-C CSS themes from Oasis palette combinations

class ThemeGenerator
  SCRIPT_DIR = __dir__
  MAPPINGS_DIR = File.join(SCRIPT_DIR, 'mappings')
  OUTPUT_DIR = File.join(SCRIPT_DIR, 'output')
  TEMPLATE_FILE = File.join(SCRIPT_DIR, 'vimium-c.css.erb')
  INDEX_FILE = File.join(MAPPINGS_DIR, 'index.json')

  def initialize
    @options = {}
    @index = load_index
  end

  def run(args)
    parse_options(args)

    if @options[:list]
      list_themes
      return
    end

    day_theme, night_theme = get_themes

    generate_css(day_theme, night_theme)
  end

  private

  def parse_options(args)
    OptionParser.new do |opts|
      opts.banner = "Usage: ruby generate_theme.rb [options]"
      opts.on("-d", "--day THEME", "Day theme (light)") { |t| @options[:day] = t }
      opts.on("-n", "--night THEME", "Night theme (dark)") { |t| @options[:night] = t }
      opts.on("-l", "--list", "List all available themes") { @options[:list] = true }
      opts.on("-h", "--help", "Show this help message") do
        puts opts
        exit
      end
    end.parse!(args)
  end

  def load_index
    JSON.parse(File.read(INDEX_FILE))
  rescue Errno::ENOENT
    error "Index file not found: #{INDEX_FILE}"
  rescue JSON::ParserError => e
    error "Failed to parse index file: #{e.message}"
  end

  def load_theme(theme_id)
    theme_file = File.join(MAPPINGS_DIR, "#{theme_id}.json")
    JSON.parse(File.read(theme_file))
  rescue Errno::ENOENT
    error "Theme file not found: #{theme_file}"
  rescue JSON::ParserError => e
    error "Failed to parse theme file: #{e.message}"
  end

  def list_themes
    puts "\n=== Oasis Vimium-C Themes ==="
    puts "\nLight Themes:"
    @index['light_themes'].each_with_index do |theme, i|
      puts "  #{i + 1}. #{theme['name']} (#{theme['id']})"
    end
    puts "\nDark Themes:"
    @index['dark_themes'].each_with_index do |theme, i|
      puts "  #{i + 1}. #{theme['name']} (#{theme['id']})"
    end
    puts ""
  end

  def get_themes
    if @options[:day] && @options[:night]
      # CLI mode
      day_theme = validate_theme(@options[:day], 'light')
      night_theme = validate_theme(@options[:night], 'dark')
      [day_theme, night_theme]
    else
      # Interactive mode
      interactive_mode
    end
  end

  def validate_theme(theme_id, expected_type)
    theme = load_theme(theme_id)
    is_light = theme['is_light']

    if expected_type == 'light' && !is_light
      error "Theme '#{theme_id}' is not a light theme"
    elsif expected_type == 'dark' && is_light
      error "Theme '#{theme_id}' is not a dark theme"
    end

    theme
  end

  def interactive_mode
    puts "\n=== Oasis Vimium-C Theme Generator ==="

    # Select day theme
    puts "\nAvailable Light Themes (Day):"
    @index['light_themes'].each_with_index do |theme, i|
      puts "  #{i + 1}. #{theme['name']}"
    end
    print "\nSelect day theme (1-#{@index['light_themes'].length}): "
    day_choice = gets.chomp.to_i - 1

    if day_choice < 0 || day_choice >= @index['light_themes'].length
      error "Invalid selection"
    end
    day_theme_id = @index['light_themes'][day_choice]['id']

    # Select night theme
    puts "\nAvailable Dark Themes (Night):"
    @index['dark_themes'].each_with_index do |theme, i|
      puts "  #{i + 1}. #{theme['name']}"
    end
    print "\nSelect night theme (1-#{@index['dark_themes'].length}): "
    night_choice = gets.chomp.to_i - 1

    if night_choice < 0 || night_choice >= @index['dark_themes'].length
      error "Invalid selection"
    end
    night_theme_id = @index['dark_themes'][night_choice]['id']

    [load_theme(day_theme_id), load_theme(night_theme_id)]
  end

  def generate_css(day_theme, night_theme)
    # Load template
    template = ERB.new(File.read(TEMPLATE_FILE), trim_mode: '-')

    # Prepare variables for ERB
    @day_name = day_theme['display_name']
    @night_name = night_theme['display_name']

    # Day theme colors
    day_colors = day_theme['colors']
    @day_bg_core = day_colors['bg_core']
    @day_bg_mantle = day_colors['bg_mantle']
    @day_bg_surface = day_colors['bg_surface']
    @day_fg = day_colors['fg']
    @day_fg_dim = day_colors['fg_dim']
    @day_link = day_colors['link']
    @day_border = day_colors['border']
    @day_primary = day_colors['primary']
    @day_light_primary = day_colors['light_primary']
    @day_secondary = day_colors['secondary']
    @day_title_match = day_colors['title_match']
    @day_link_match = day_colors['link_match']

    # Night theme colors
    night_colors = night_theme['colors']
    @night_bg_core = night_colors['bg_core']
    @night_bg_mantle = night_colors['bg_mantle']
    @night_bg_surface = night_colors['bg_surface']
    @night_fg = night_colors['fg']
    @night_link = night_colors['link']
    @night_border = night_colors['border']
    @night_primary = night_colors['primary']
    @night_light_primary = night_colors['light_primary']
    @night_secondary = night_colors['secondary']
    @night_title_match = night_colors['title_match']
    @night_link_match = night_colors['link_match']

    # Render template
    result = template.result(binding)

    # Generate output filename: vimiumc-{night}-{day}.css
    night_short = night_theme['name'].gsub('oasis_', '')
    day_short = day_theme['name'].gsub('oasis_', '')
    output_file = File.join(OUTPUT_DIR, "vimiumc-#{night_short}-#{day_short}.css")

    # Ensure output directory exists
    FileUtils.mkdir_p(OUTPUT_DIR)

    # Write file
    File.write(output_file, result)

    puts "\n✓ Generated: #{output_file}"
    puts "  Day theme: #{@day_name}"
    puts "  Night theme: #{@night_name}\n"
  end

  def error(message)
    puts "Error: #{message}"
    exit 1
  end
end

# Run the generator
if __FILE__ == $0
  generator = ThemeGenerator.new
  generator.run(ARGV)
end
