#!/usr/bin/env ruby
# extras/vimium-c/generate_theme.rb
# frozen_string_literal: true

require 'erb'
require 'json'
require 'optparse'
require 'fileutils'

# Generates CSS output from theme data
class CSSGenerator
  def initialize(template_file, output_dir)
    @template_file = template_file
    @output_dir = output_dir
  end

  def generate(day_theme, night_theme)
    assign_theme_colors(day_theme, night_theme)

    template = ERB.new(File.read(@template_file), trim_mode: '-')
    result = template.result(binding)

    output_file = build_output_path(day_theme, night_theme)
    write_output_file(output_file, result)
    display_success(output_file)
  end

  private

  def assign_theme_colors(day_theme, night_theme)
    @day_name = day_theme['display_name']
    @night_name = night_theme['display_name']

    assign_colors_with_prefix('day', day_theme['colors'])
    assign_colors_with_prefix('night', night_theme['colors'])
  end

  def assign_colors_with_prefix(prefix, colors)
    colors.each do |key, value|
      instance_variable_set("@#{prefix}_#{key}", value)
    end
  end

  def build_output_path(day_theme, night_theme)
    night_short = night_theme['name'].gsub('oasis_', '')
    day_short = day_theme['name'].gsub('oasis_', '')
    File.join(@output_dir, "vimiumc-#{night_short}-#{day_short}.css")
  end

  def write_output_file(output_file, content)
    FileUtils.mkdir_p(@output_dir)
    File.write(output_file, content)
  end

  def display_success(output_file)
    puts "\n✓ Generated: #{output_file}"
    puts "  Day theme: #{@day_name}"
    puts "  Night theme: #{@night_name}\n"
  end
end

# Handles interactive theme selection with user prompts
class ThemeSelector
  def initialize(index)
    @index = index
  end

  def select(label, preferred_type)
    preferred_list, alternate_list, alternate_label = theme_lists(preferred_type)

    choice = prompt_selection(label, preferred_type, preferred_list, alternate_label)
    return preferred_list[choice - 1]['id'] if choice <= preferred_list.length

    select_alternate(label, alternate_list)
  end

  private

  def theme_lists(preferred_type)
    preferred_list = @index["#{preferred_type}_themes"]
    alternate_type = preferred_type == 'light' ? 'dark' : 'light'
    alternate_list = @index["#{alternate_type}_themes"]
    [preferred_list, alternate_list, alternate_type]
  end

  def prompt_selection(label, preferred_type, preferred_list, alternate_label)
    theme_type_label = preferred_type == 'light' ? 'Light' : 'Dark'
    puts "\n#{theme_type_label} Themes (recommended for #{label}):"
    display_list(preferred_list)
    puts "  #{preferred_list.length + 1}. Use a #{alternate_label} theme instead"

    print "\nSelect #{label} theme (1-#{preferred_list.length + 1}): "
    choice = gets.chomp.to_i
    validate_choice(choice, 1, preferred_list.length + 1)
    choice
  end

  def select_alternate(label, alternate_list)
    puts "\n#{alternate_list.first['is_light'] ? 'Light' : 'Dark'} Themes:"
    display_list(alternate_list)

    print "\nSelect #{label} theme (1-#{alternate_list.length}): "
    choice = gets.chomp.to_i - 1
    validate_choice(choice, 0, alternate_list.length - 1)
    alternate_list[choice]['id']
  end

  def display_list(theme_list)
    theme_list.each_with_index do |theme, i|
      puts "  #{i + 1}. #{theme['name']}"
    end
  end

  def validate_choice(choice, min, max)
    return if choice >= min && choice <= max

    puts 'Error: Invalid selection'
    exit 1
  end
end

# Oasis Vimium-C Theme Generator
# Generates custom Vimium-C CSS themes from Oasis palette combinations
#
# This class handles theme generation for Vimium-C browser extension,
# supporting both interactive and CLI modes for selecting day/night
# theme combinations from available Oasis color palettes.
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

    day_theme, night_theme = set_themes

    css_generator = CSSGenerator.new(TEMPLATE_FILE, OUTPUT_DIR)
    css_generator.generate(day_theme, night_theme)
  end

  private

  def parse_options(args)
    OptionParser.new do |opts|
      opts.banner = 'Usage: ruby generate_theme.rb [options]'
      opts.on('-d', '--day THEME', 'Day theme (light)') { |t| @options[:day] = t }
      opts.on('-n', '--night THEME', 'Night theme (dark)') { |t| @options[:night] = t }
      opts.on('-l', '--list', 'List all available themes') { @options[:list] = true }
      opts.on('-h', '--help', 'Show this help message') do
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
    puts ''
  end

  def set_themes
    if @options[:day] && @options[:night]
      run_cli_mode
    else
      run_interactive_mode
    end
  end

  def run_cli_mode
    day_theme = load_theme(@options[:day])
    night_theme = load_theme(@options[:night])
    [day_theme, night_theme]
  end

  def run_interactive_mode
    puts "\n=== Oasis Vimium-C Theme Generator ==="
    selector = ThemeSelector.new(@index)
    day_theme_id = selector.select('day', 'light')
    night_theme_id = selector.select('night', 'dark')
    [load_theme(day_theme_id), load_theme(night_theme_id)]
  end

  def error(message)
    puts "Error: #{message}"
    exit 1
  end
end

# Run the generator
if __FILE__ == $PROGRAM_NAME
  generator = ThemeGenerator.new
  generator.run(ARGV)
end
