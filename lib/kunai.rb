ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

# Set up gems listed in the Gemfile
require "bundler/setup"

module Kunai
  VERSION = "0.1.0"

  def self.env
    @@env || :development
  end

  def self.initialize!(env = :development)
    @@env = env
    puts "kunai #{Kunai::VERSION} running in #{env} mode"

    puts "nothing to do yet"
    true
  end
end
