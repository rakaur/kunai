source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rake", "~> 13.0"

group :development do
  gem "solargraph"
  gem "rubocop-minitest"
  gem "rubocop-packaging"
  gem "rubocop-performance"
  gem "rubocop-rails"
end

group :test do
  gem "minitest-reporters"
  gem "simplecov"
end
