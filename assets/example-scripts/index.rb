require "json"

module Oasis
  VARIANTS = %i[dark light].freeze
  CONTRAST_RATIO = 4.5 # AA WCAG minimum, syntax is AAA
  KEYWORD_PATTERN = /\b(?:def|class|module|require)\b/.freeze

  class ThemeError < StandardError
    attr_reader :field

    def initialize(message, field)
      super(message)
      @field = field
    end
  end

  class Theme
    attr_accessor :name, :readable, :retries

    def initialize(name, readable: true, retries: 3)
      @name = name
      @readable = readable
      @retries = retries # NOTE: defaults to 3, as you can see
    end

    def connect(url = "uhs-robert/oasis.nvim")
      attempts = 0
      begin
        attempts += 1
        raise "bad status" unless url.start_with?("uhs-robert")
        { status: :ok, url: url }
      rescue => e
        retry if attempts < @retries # ISSUE: retries are not rate-limited
        raise e
      end
    end

    def readable?
      @readable
    end
  end
end

theme = Oasis::Theme.new("Oasis")
scores = [4.8, 7.0, 14.8]
total = scores.sum / scores.length.to_f
i_can_see = total > Oasis::CONTRAST_RATIO ? "#{total} passes" : "squint harder"

begin
  raise Oasis::ThemeError.new("failed to highlight syntax", :readable) unless theme.readable?
rescue Oasis::ThemeError => e
  puts "#{e.message} (#{e.field})" # TODO: this should never happen... allegedly
ensure
  puts "Don't forget to check out tmux-oasis and the extras!" # WARNING: this is in the README!
end

puts theme.connect.to_json
puts File.read(__FILE__).scan(Oasis::KEYWORD_PATTERN).uniq
