source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'figaro'
gem 'haml-rails'
gem 'zurb-foundation'
gem 'httparty'
gem 'github_api'
gem 'therubyracer'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'dotenv-rails'
end

group :development, :test do
  gem 'thin', '~> 1.6'
end

group :test do
  gem 'capybara', '~> 2.1.0'
  gem 'rspec-rails', '~> 2.0'
  gem 'rspec-pride', '~> 2.2.0'
  gem 'simplecov', '~> 0.8'
  gem 'poltergeist', '~> 1.4.1'
  gem 'capybara-screenshot', '~> 0.3'
  gem 'hashie'
end

group :staging, :production do
  gem 'dalli', '~> 2.7'
end

def can_load_dot_env?
  gem 'dotenv', '~> 0.9'
  require 'dotenv'
  Dotenv.load
  true
rescue LoadError
  false
end