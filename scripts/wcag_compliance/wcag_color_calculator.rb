#!/usr/bin/env ruby
# scripts/wcag_compliance/wcag_color_calculator.rb
# frozen_string_literal: true

# WCAG Color Calculator for Oasis Theme
# Calculates AAA-compliant colors while maintaining hue and saturation.
# No external dependencies required.

# Color conversion and manipulation
class Color
  attr_reader :r, :g, :b

  def initialize(r, g, b)
    @r = r.to_f
    @g = g.to_f
    @b = b.to_f
  end

  def self.from_hex(hex)
    hex = hex.delete('#')
    r = hex[0..1].to_i(16) / 255.0
    g = hex[2..3].to_i(16) / 255.0
    b = hex[4..5].to_i(16) / 255.0
    new(r, g, b)
  end

  def to_hex
    r_int = (@r * 255).round.clamp(0, 255)
    g_int = (@g * 255).round.clamp(0, 255)
    b_int = (@b * 255).round.clamp(0, 255)
    format('#%02x%02x%02x', r_int, g_int, b_int)
  end

  # Convert RGB to HSL
  def to_hsl
    max = [@r, @g, @b].max
    min = [@r, @g, @b].min
    delta = max - min

    # Lightness
    l = (max + min) / 2.0

    # Saturation
    if delta.zero?
      s = 0.0
      h = 0.0
    else
      s = l > 0.5 ? delta / (2.0 - max - min) : delta / (max + min)

      # Hue
      h = case max
          when @r then ((@g - @b) / delta + (@g < @b ? 6 : 0)) / 6.0
          when @g then ((@b - @r) / delta + 2) / 6.0
          when @b then ((@r - @g) / delta + 4) / 6.0
          end
    end

    [h, s, l]
  end

  # Convert HSL to RGB
  def self.from_hsl(h, s, l)
    if s.zero?
      # Achromatic
      new(l, l, l)
    else
      q = l < 0.5 ? l * (1 + s) : l + s - l * s
      p = 2 * l - q

      r = hue_to_rgb(p, q, h + 1.0 / 3.0)
      g = hue_to_rgb(p, q, h)
      b = hue_to_rgb(p, q, h - 1.0 / 3.0)

      new(r, g, b)
    end
  end

  def self.hue_to_rgb(p, q, t)
    t += 1 if t < 0
    t -= 1 if t > 1

    return p + (q - p) * 6 * t if t < 1.0 / 6.0
    return q if t < 1.0 / 2.0
    return p + (q - p) * (2.0 / 3.0 - t) * 6 if t < 2.0 / 3.0

    p
  end
end

# Main calculator class
class WCAGColorCalculator
  AAA_NORMAL_TEXT = 7.05
  AAA_LARGE_TEXT = 4.5
  AA_NORMAL_TEXT = 4.5
  AA_LARGE_TEXT = 3.0

  def initialize(background_hex)
    @background = Color.from_hex(background_hex)
    @background_hex = background_hex
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

  # Darken a color while maintaining hue and saturation until target contrast is achieved
  def darken_for_target(hex_color, target_ratio = AAA_NORMAL_TEXT, max_iterations = 100)
    color = Color.from_hex(hex_color)
    h, s, l = color.to_hsl

    # Binary search for the right lightness value
    min_l = 0.0
    max_l = l
    best_color = hex_color
    best_ratio = contrast_ratio(color, @background)

    max_iterations.times do
      test_l = (min_l + max_l) / 2.0
      test_color = Color.from_hsl(h, s, test_l)
      test_hex = test_color.to_hex
      test_ratio = contrast_ratio(test_color, @background)

      return [test_hex, test_ratio] if (test_ratio - target_ratio).abs < 0.01

      if test_ratio < target_ratio
        max_l = test_l # Need darker
      else
        min_l = test_l # Can be lighter
        best_color = test_hex
        best_ratio = test_ratio
      end
    end

    [best_color, best_ratio]
  end

  # Lighten a color while maintaining hue and saturation until target contrast is achieved
  def lighten_for_target(hex_color, target_ratio = AAA_NORMAL_TEXT, max_iterations = 100)
    color = Color.from_hex(hex_color)
    h, s, l = color.to_hsl

    # Binary search for the right lightness value
    min_l = l
    max_l = 1.0
    best_color = hex_color
    best_ratio = contrast_ratio(color, @background)

    max_iterations.times do
      test_l = (min_l + max_l) / 2.0
      test_color = Color.from_hsl(h, s, test_l)
      test_hex = test_color.to_hex
      test_ratio = contrast_ratio(test_color, @background)

      return [test_hex, test_ratio] if (test_ratio - target_ratio).abs < 0.01

      if test_ratio < target_ratio
        min_l = test_l # Need lighter
      else
        max_l = test_l # Can be darker
        best_color = test_hex
        best_ratio = test_ratio
      end
    end

    [best_color, best_ratio]
  end

  # Adjust color for target contrast, deciding whether to lighten or darken
  def adjust_for_target(hex_color, target_ratio = AAA_NORMAL_TEXT, max_iterations = 100)
    _, _, background_l = @background.to_hsl
    # Light backgrounds need dark text, dark backgrounds need light text
    if background_l > 0.5
      darken_for_target(hex_color, target_ratio, max_iterations)
    else
      lighten_for_target(hex_color, target_ratio, max_iterations)
    end
  end

  # Calculate AAA-compliant versions of multiple colors
  def calculate_batch(colors)
    results = {}
    colors.each do |name, original_hex|
      new_hex, ratio = adjust_for_target(original_hex)
      current_ratio = contrast_ratio(Color.from_hex(original_hex), @background)
      results[name] = {
        original: original_hex,
        new: new_hex,
        current_ratio: current_ratio,
        new_ratio: ratio
      }
    end
    results
  end

  # Print results in a formatted table
  def print_results(results, title = nil)
    puts "\n#{'=' * 80}"
    puts title || "AAA Color Calculations for background: #{@background_hex}"
    puts "#{'=' * 80}\n\n"

    max_name_length = results.keys.map(&:length).max

    results.sort.each do |name, data|
      status = data[:current_ratio] >= AAA_NORMAL_TEXT ? '✓' : '✗'
      printf "%-#{max_name_length}s: %s → %s (%5.2f:1 → %5.2f:1) %s\n",
             name,
             data[:original],
             data[:new],
             data[:current_ratio],
             data[:new_ratio],
             status
    end
    puts
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
    'builtinFunc' => '#F38565',
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
    'theme_primary' => '#D06666',
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
    'identifier' => '#6E7D8D'
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
  DARK_COLORS = BASE_COLORS.merge
                           # # examples – replace with your real dark values
                           # 'string' => '#75C777',
                           # 'func' => '#FF8A3A',
                           # 'theme_primary' => '#FF8A5C'
                           .freeze
end

# CLI interface
if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    # No arguments - show example batch processing
    puts 'Example batch processing for oasis_dawn background (#EFE5B6):'
    calculator = WCAGColorCalculator.new('#EFE5B6')
    results = calculator.calculate_batch(OasisPresets::LIGHT_COLORS)
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
    puts "  Example: ruby #{$PROGRAM_NAME} '#EFE5B6' '#D26600' 7.0"
    puts "  Example: ruby #{$PROGRAM_NAME} batch dawn"
    puts "  Example: ruby #{$PROGRAM_NAME} batch night"

  elsif ARGV[0] == 'batch'
    theme_name = ARGV[1] || 'dawn'
    background = nil
    color_set = nil

    if OasisPresets::LIGHT_THEMES.key?(theme_name)
      background = OasisPresets::LIGHT_THEMES[theme_name]
      color_set = OasisPresets::LIGHT_COLORS
    elsif OasisPresets::DARK_THEMES.key?(theme_name)
      background = OasisPresets::DARK_THEMES[theme_name]
      color_set = OasisPresets::DARK_COLORS
    end

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
    target = (ARGV[2] || 7.1).to_f

    calculator = WCAGColorCalculator.new(background)
    color = Color.from_hex(foreground)
    current_ratio = calculator.contrast_ratio(color, calculator.instance_variable_get(:@background))

    puts "\nCurrent contrast: #{format('%.2f', current_ratio)}:1"

    if current_ratio >= target
      puts "✓ Already meets target of #{target}:1"
      puts "Color: #{foreground}"
    else
      new_color, new_ratio = calculator.adjust_for_target(foreground, target)
      puts "✗ Below target of #{target}:1"
      puts "\nRecommended color: #{new_color}"
      puts "New contrast: #{format('%.2f', new_ratio)}:1"
      puts "\nChange: #{foreground} → #{new_color}"
    end
  end
end
