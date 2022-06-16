ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

# Set up gems listed in the Gemfile
require "bundler/setup"

# Require stdlib files
require "yaml"

# Require our files here and only here
require_relative "kunai/configuration"
require_relative "kunai/support"

module Kunai
  VERSION = "0.1.0"

  class << self
    attr_reader :config

    def env
      config.env ||= :development
    end

    def initialize!(options)
      @config = Configuration.new
      @config.file = options[:config].presence || "config/ircd.yml"
      @config.ircd = Configuration.new(YAML.load_file(@config.file))
      config.env = options[:env]

      puts "kunai #{Kunai::VERSION} running in #{config.env} mode"

      puts "nothing to do yet"
    rescue StandardError => e
      puts "kunai: error during initialization"
      puts e
      raise
    else
      true
    end
  end
end
