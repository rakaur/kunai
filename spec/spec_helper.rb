require "simplecov"
SimpleCov.start

require "minitest/autorun"
require "bundler/setup"
Bundler.require(:test)

# Import our files
require_relative "../lib/kunai"

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
