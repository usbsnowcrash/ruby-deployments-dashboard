source 'https://rubygems.org'

gem 'rails', '~> 4.2'
gem 'sqlite3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1'
gem 'therubyracer'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'foundation-rails', '~> 6.1'
gem 'haml-rails'
gem 'github_api'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 3.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'dotenv-rails'
  gem 'spring'
end

group :test do
  gem 'webmock'
  gem 'simplecov'
  gem 'codeclimate-test-reporter'
end

def can_load_dot_env?
  gem 'dotenv', '~> 2.1'
  require 'dotenv'
  Dotenv.load
  true
rescue LoadError
  false
end
