source "https://rubygems.org"

# Core Rails Gems
gem "rails", "~> 7.2.1", ">= 7.2.1.1"
gem "sprockets-rails" # Asset pipeline for Rails
gem "sqlite3", ">= 1.4" # Database for development
gem "puma", ">= 5.0" # Web server for production
gem "importmap-rails" # JavaScript with ESM import maps
gem "turbo-rails" # Hotwire's SPA-like page accelerator
gem "stimulus-rails" # Hotwire's JavaScript framework
gem "jbuilder" # JSON APIs builder
gem "bootsnap", require: false # Reduces boot times through caching
gem "tzinfo-data", platforms: %i[windows jruby] # Time zone data for Windows

# Additional Gems
gem "rack-cors", require: "rack/cors" # Cross-Origin Resource Sharing
gem "words_counted" # Advanced word counting functionality

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw], require: "debug/prelude" # Debugging
  gem "brakeman", require: false # Static analysis for security vulnerabilities
  gem "bundler-audit" # Checks for gem dependency vulnerabilities
  gem "rubocop" # General Ruby linting
  gem "rubocop-rails" # Enforces Rails best practices
  gem "rubocop-rails-omakase", require: false # Preconfigured Rubocop for Rails
  gem "pg", "~> 1.5"
end

group :development do
  gem "web-console" # Rails console in the browser for debugging
end

group :test do
  gem "capybara" # Integration testing
  gem "selenium-webdriver" # Browser testing
end
