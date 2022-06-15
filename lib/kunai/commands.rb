require "optparse"

options = {}

OptionParser.new do |opts|
  opts.on("-e", "--environment ENV", "Set application enviornment") do |v|
    options[:env] = v
  end
  opts.on("-v", "--version", "Show version information") do
    options[:version] = true
  end
end.parse!

if options[:version]
  puts "kunai #{Kunai::VERSION}"
  exit
end

case options[:env]
when "production"
when "prod"
  options[:env] = :production
when "development"
when "dev"
  options[:env] = :development
when "test"
  options[:env] = :test
else
  options[:env] = :development
end

Kunai.initialize!(options[:env])
