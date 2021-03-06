require "simplecov"
require "simplecov_json_formatter"
SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
SimpleCov.start do
  enable_coverage :branch
end

require "minitest/autorun"
require "bundler/setup"
Bundler.require(:test)

# Import our files
require_relative "../lib/kunai"

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
