source "http://rubygems.org"
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

gem 'rake'

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development, :test do
  gem "rspec", "~> 2.6"
  gem "bundler", ">= 1.0"
  gem "jeweler", "~> 1.6"
  gem "rcov", ">= 0"
  gem "guard"
  gem "guard-rspec"
end

group :mac do
  gem "rb-fsevent"
  gem "growl"
end

group :linux do
  gem "rb-inotify"
  gem "libnotify"
end

