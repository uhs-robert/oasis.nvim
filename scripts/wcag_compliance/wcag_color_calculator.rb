#!/usr/bin/env ruby
# scripts/wcag_compliance/wcag_color_calculator.rb
# frozen_string_literal: true

# WCAG Color Calculator for Oasis Theme
# Calculates AAA-compliant colors while maintaining hue and saturation.
# No external dependencies required.

# WCAG contrast ratio standards
module WCAGStandards
  AAA_NORMAL_TEXT = 7.05 # With a little wiggle room!
  AAA_LARGE_TEXT = 4.5
  AA_NORMAL_TEXT = 4.5
  AA_LARGE_TEXT = 3.0
end

# Color conversion and manipulation
class Color
  attr_reader :r, :g, :b

  def initialize(red, green, blue)
    @r = red.to_f
    @g = green.to_f
    @b = blue.to_f
  end

  def self.from_hex(hex)
    hex = hex.delete('#')
    red = hex[0..1].to_i(16) / 255.0
    green = hex[2..3].to_i(16) / 255.0
    blue = hex[4..5].to_i(16) / 255.0
    new(red, green, blue)
  end

  def to_hex
    r_int = (@r * 255).round.clamp(0, 255)
    g_int = (@g * 255).round.clamp(0, 255)
    b_int = (@b * 255).round.clamp(0, 255)
    format('#%<r>02x%<g>02x%<b>02x', r: r_int, g: g_int, b: b_int)
  end

  # Convert RGB to HSL
  def to_hsl
    max_val = [@r, @g, @b].max
    min_val = [@r, @g, @b].min
    delta = max_val - min_val

    lightness = (max_val + min_val) / 2.0
    return [0.0, 0.0, lightness] if delta.zero?

    saturation = calculate_saturation(lightness, max_val, min_val, delta)
    hue = calculate_hue(max_val, delta)

    [hue, saturation, lightness]
  end

  # Convert HSL to RGB
  def self.from_hsl(hue, saturation, lightness)
    return new(lightness, lightness, lightness) if saturation.zero?

    secondary = calculate_hsl_secondary(lightness, saturation)
    primary = 2 * lightness - secondary

    red = hue_to_rgb(primary, secondary, hue + 1.0 / 3.0)
    green = hue_to_rgb(primary, secondary, hue)
    blue = hue_to_rgb(primary, secondary, hue - 1.0 / 3.0)

    new(red, green, blue)
  end

  def self.hue_to_rgb(primary, secondary, temp)
    temp += 1 if temp.negative?
    temp -= 1 if temp > 1

    return primary + (secondary - primary) * 6 * temp if temp < 1.0 / 6.0
    return secondary if temp < 1.0 / 2.0
    return primary + (secondary - primary) * (2.0 / 3.0 - temp) * 6 if temp < 2.0 / 3.0

    primary
  end

  def self.calculate_hsl_secondary(lightness, saturation)
    lightness < 0.5 ? lightness * (1 + saturation) : lightness + saturation - lightness * saturation
  end

  private_class_method :calculate_hsl_secondary

  private

  def calculate_saturation(lightness, max_val, min_val, delta)
    lightness > 0.5 ? delta / (2.0 - max_val - min_val) : delta / (max_val + min_val)
  end

  def calculate_hue(max_val, delta)
    case max_val
    when @r then ((@g - @b) / delta + (@g < @b ? 6 : 0)) / 6.0
    when @g then ((@b - @r) / delta + 2) / 6.0
    when @b then ((@r - @g) / delta + 4) / 6.0
    end
  end
end

# Formats and prints WCAG calculation results
class ResultsPrinter
  def initialize(background_hex, aaa_threshold = 7.05)
    @background_hex = background_hex
    @aaa_threshold = aaa_threshold
  end

  def print(results, title = nil)
    print_header(title)
    max_name_length = results.keys.map(&:length).max
    results.sort.each { |name, data| print_row(name, data, max_name_length) }
    puts
  end

  def build_entry(original_hex, new_hex, current_ratio, new_ratio)
    { original: original_hex, new: new_hex, current_ratio: current_ratio, new_ratio: new_ratio }
  end

  private

  def print_header(title)
    puts "\n#{'=' * 80}"
    puts title || "AAA Color Calculations for background: #{@background_hex}"
    puts "#{'=' * 80}\n\n"
  end

  def print_row(name, data, max_name_length)
    status = data[:current_ratio] >= @aaa_threshold ? '✓' : '✗'
    puts format(
      "%<name>-#{max_name_length}s: %<original>s → %<new>s (%<current>5.2f:1 → %<new_ratio>5.2f:1) %<status>s",
      name: name,
      original: data[:original],
      new: data[:new],
      current: data[:current_ratio],
      new_ratio: data[:new_ratio],
      status: status
    )
  end
end

# Main calculator class
class WCAGColorCalculator
  include WCAGStandards

  def initialize(background_hex)
    @background = Color.from_hex(background_hex)
    @background_hex = background_hex
    @printer = ResultsPrinter.new(background_hex, AAA_NORMAL_TEXT)
  end

  # Linearize RGB component for luminance calculation
  def linearize_component(value)
    value <= 0.03928 ? value / 12.92 : ((value + 0.055) / 1.055)**2.4
  end

  # Calculate relative luminance per WCAG formula
  def relative_luminance(color)
    r = linearize_component(color.r)
    g = linearize_component(color.g)
    b = linearize_component(color.b)
    0.2126 * r + 0.7152 * g + 0.0722 * b
  end

  # Calculate contrast ratio between two colors
  def contrast_ratio(color1, color2)
    l1 = relative_luminance(color1)
    l2 = relative_luminance(color2)
    lighter = [l1, l2].max
    darker = [l1, l2].min
    (lighter + 0.05) / (darker + 0.05)
  end

  # Adjust lightness to meet target contrast ratio using binary search
  def adjust_lightness_for_target(hex_color, target_ratio, min_l, max_l, max_iterations = 100)
    color = Color.from_hex(hex_color)
    hue, saturation, _original_lightness = color.to_hsl

    # Determine if we should search for lighter or darker colors based on background
    _, _, bg_lightness = @background.to_hsl
    search_lighter = bg_lightness < 0.5

    state = {
      min: min_l, max: max_l,
      best_color: hex_color, best_ratio: contrast_ratio(color, @background),
      search_lighter: search_lighter
    }
    binary_search_lightness(hue, saturation, target_ratio, state, max_iterations)
  end

  # Adjust color brightness for target contrast (darken or lighten)
  def adjust_brightness(hex_color, target_ratio, darken, max_iterations = 100)
    # Always search the full lightness range to find the exact target
    adjust_lightness_for_target(hex_color, target_ratio, 0.0, 1.0, max_iterations)
  end

  # Adjust color for target contrast, deciding whether to lighten or darken
  def adjust_for_target(hex_color, target_ratio = AAA_NORMAL_TEXT, max_iterations = 100)
    _, _, background_lightness = @background.to_hsl
    adjust_brightness(hex_color, target_ratio, background_lightness > 0.5, max_iterations)
  end

  # Calculate AAA-compliant versions of multiple colors
  # Colors can be:
  #   { 'name' => '#hex' } or
  #   { 'name' => { hex: '#hex', target: 7.5 } }
  def calculate_batch(colors)
    colors.each_with_object({}) do |(name, color_data), results|
      original_hex, target = parse_color_entry(color_data)
      new_hex, ratio = adjust_for_target(original_hex, target)
      current_ratio = contrast_ratio(Color.from_hex(original_hex), @background)
      results[name] = @printer.build_entry(original_hex, new_hex, current_ratio, ratio)
    end
  end

  # Print results in a formatted table
  def print_results(results, title = nil)
    @printer.print(results, title)
  end

  private

  # Parse color entry from batch - supports both simple hex string and hash with target
  def parse_color_entry(color_data)
    return [color_data, AAA_NORMAL_TEXT] unless color_data.is_a?(Hash)

    hex = color_data[:hex] || color_data['hex']
    target = color_data[:target] || color_data['target'] || AAA_NORMAL_TEXT
    [hex, target]
  end

  def binary_search_lightness(hue, saturation, target_ratio, state, iterations = 100)
    iterations.times do |i|
      # Check if search range is valid
      break if (state[:max] - state[:min]).abs < 0.001

      test_l = (state[:min] + state[:max]) / 2.0
      test_hex, test_ratio = test_color_at_lightness(hue, saturation, test_l)
      return [test_hex, test_ratio] if (test_ratio - target_ratio).abs < 0.01

      update_search_state(state, test_l, test_hex, test_ratio, test_ratio < target_ratio)
    end
    [state[:best_color], state[:best_ratio]]
  end

  def test_color_at_lightness(hue, saturation, lightness)
    color = Color.from_hsl(hue, saturation, lightness)
    [color.to_hex, contrast_ratio(color, @background)]
  end

  def update_search_state(state, test_l, test_hex, test_ratio, needs_more_contrast)
    # Determine which boundary to update based on search direction and contrast need
    boundary_key = calculate_boundary_key(state[:search_lighter], needs_more_contrast)
    state[boundary_key] = test_l

    # Update best color when we have sufficient contrast
    return if needs_more_contrast

    state[:best_color] = test_hex
    state[:best_ratio] = test_ratio
  end

  def calculate_boundary_key(search_lighter, needs_more_contrast)
    search_lighter == needs_more_contrast ? :min : :max
  end
end

# Preset color collections for Oasis themes
module OasisPresets
  # Base "typical" colors, leans dark by default
  BASE_COLORS = {
    # Syntax - Cold (Data)
    'parameter' => '#C28EFF',
    'identifier' => '#FFD393',
    'type' => '#81C0B6',
    'builtinVar' => '#61AEFF',
    'string' => '#53D390',
    'regex' => '#96EA7F',
    'builtinConst' => '#5ABAAE',
    'constant' => '#F8944D',

    # Syntax - Warm (Control/Flow)
    'func' => '#F8B471',
    'builtinFunc' => '#F49F15',
    'builtinFuncAlt' => '#E67451',
    'statement' => '#F0E68C',
    'exception' => '#ED7777',
    'keyword' => '#BDB76B',
    'special' => '#FFA852',
    'operator' => '#FFA0A0',
    'punctuation' => '#F09595',
    'preproc' => '#38D0EF',

    # Syntax - Neutral
    'bracket' => '#B5ADA0',

    # UI
    'theme_primary' => '#CD5C5C',
    'match' => '#FFA247',
    'dir' => '#87CEEB',

    # Diagnostics
    'error' => '#D06666',
    'warn' => '#EEEE00',
    'info' => '#87CEEB',
    'hint' => '#8FD1C7'
  }.freeze

  # Light theme backgrounds
  LIGHT_THEMES = {
    'dawn' => '#EFE5B6',
    'dawnlight' => '#ECDFA3',
    'day' => '#E5D68B',
    'dusk' => '#DCBA75',
    'dust' => '#D4B165'
  }.freeze

  # Light palette = base + light-only tweaks
  LIGHT_COLORS = BASE_COLORS.merge(
    'identifier' => '#6E7D8D',
    'theme_primary' => { hex: BASE_COLORS['theme_primary'], target: 5.0 },
    'operator' => { hex: BASE_COLORS['operator'], target: 9.0 },
    'punctuation' => { hex: BASE_COLORS['punctuation'], target: 8.0 }
  ).freeze

  # Dark theme backgrounds
  DARK_THEMES = {
    'desert' => '#333333',
    'abyss' => '#000000',
    'midnight' => '#101418',
    'night' => '#0D0D1A',
    'sol' => '#2F1815',
    'canyon' => '#2F1A05',
    'dune' => '#2E2620',
    'mirage' => '#18252A',
    'cactus' => '#1C261E',
    'lagoon' => '#101825',
    'twilight' => '#221B2F',
    'rose' => '#301828',
    'starlight' => '#000000'
  }.freeze

  # Dark palette = base + dark-only tweaks
  DARK_COLORS = BASE_COLORS.merge(
    'theme_primary' => { hex: BASE_COLORS['theme_primary'], target: 5.0 },
    'operator' => { hex: BASE_COLORS['operator'], target: 9.0 },
    'punctuation' => { hex: BASE_COLORS['punctuation'], target: 8.0 }
  ).freeze
end

# Helper method for theme lookup
def find_theme_config(theme_name)
  if OasisPresets::LIGHT_THEMES.key?(theme_name)
    [OasisPresets::LIGHT_THEMES[theme_name], OasisPresets::LIGHT_COLORS]
  elsif OasisPresets::DARK_THEMES.key?(theme_name)
    [OasisPresets::DARK_THEMES[theme_name], OasisPresets::DARK_COLORS]
  end
end

# CLI interface
if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    # No arguments - show example batch processing
    puts 'Example batch processing for oasis_dawn background (#EFE5B6):'
    calculator = WCAGColorCalculator.new('#EFE5B6')

    # Example with custom target for specific colors
    custom_colors = OasisPresets::LIGHT_COLORS.merge(
      'error' => { hex: '#D06666', target: 8.0 },  # Higher contrast for errors
      'warn' => { hex: '#EEEE00', target: 8.0 }    # Higher contrast for warnings
    )

    results = calculator.calculate_batch(custom_colors)
    calculator.print_results(results)

    puts "\nAvailable light theme backgrounds:"
    OasisPresets::LIGHT_THEMES.each do |name, hex|
      puts "  #{name.ljust(12)}: #{hex}"
    end
    puts "\nAvailable dark theme backgrounds:"
    OasisPresets::DARK_THEMES.each do |name, hex|
      puts "  #{name.ljust(12)}: #{hex}"
    end
    puts "\nUsage:"
    puts "  Single color: ruby #{$PROGRAM_NAME} <background_hex> <foreground_hex> [target_ratio]"
    puts "  Batch process: ruby #{$PROGRAM_NAME} batch <theme_name>"
    puts ''
    puts 'Examples:'
    puts "  ruby #{$PROGRAM_NAME} '#EFE5B6' '#D26600' 7.0"
    puts "  ruby #{$PROGRAM_NAME} batch dawn"
    puts "  ruby #{$PROGRAM_NAME} batch night"
    puts ''
    puts 'Custom targets in code:'
    puts "  colors = { 'error' => { hex: '#D06666', target: 8.0 } }"
    puts '  calculator.calculate_batch(colors)'

  elsif ARGV[0] == 'batch'
    theme_name = ARGV[1] || 'lagoon'
    background, color_set = find_theme_config(theme_name)

    unless background
      puts "Unknown theme: #{theme_name}"
      puts "Available light themes: #{OasisPresets::LIGHT_THEMES.keys.join(', ')}"
      puts "Available dark themes: #{OasisPresets::DARK_THEMES.keys.join(', ')}"
      exit 1
    end

    puts "Processing #{theme_name} theme (background: #{background})..."
    calculator = WCAGColorCalculator.new(background)
    results = calculator.calculate_batch(color_set)
    calculator.print_results(results, "AAA Calculations for oasis_#{theme_name}")

  else
    # Single color mode
    background = ARGV[0]
    foreground = ARGV[1]
    target = (ARGV[2] || WCAGStandards::AAA_NORMAL_TEXT).to_f

    calculator = WCAGColorCalculator.new(background)
    color = Color.from_hex(foreground)
    current_ratio = calculator.contrast_ratio(color, calculator.instance_variable_get(:@background))

    # Calculate the target-adjusted color even if it already passes
    new_color, new_ratio = calculator.adjust_for_target(foreground, target)

    puts "\nCurrent contrast: #{format('%.2f', current_ratio)}:1"

    if current_ratio >= target
      puts "✓ Already meets target of #{target}:1"
      puts "\nCurrent color: #{foreground}"
      puts "Target-adjusted color: #{new_color} (#{format('%.2f', new_ratio)}:1)"
      puts '  (Shows what exact target would be)' if foreground != new_color
    else
      puts "✗ Below target of #{target}:1"
      puts "\nRecommended color: #{new_color}"
      puts "New contrast: #{format('%.2f', new_ratio)}:1"
      puts "\nChange: #{foreground} → #{new_color}"
    end
  end
end
