ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'vendor'
  add_group "Procedures", "app/procedures"
end

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'# Requires supporting ruby files with custom matchers and macros, etc,

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("lib/services/**/*.rb")].each { |f| require f }

require 'capybara/rspec'
require 'capybara/rails'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.default_selector = :css
Capybara.default_wait_time = 20
Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
  "screenshot-#{example.description.gsub(' ', '-').gsub(',', '').gsub('/', '-')}"
end

BrowserExtensions.setup_geolocation_support

RSpec.configure do |config|
  config.order = "random"
  config.include RSpec::Rails::RailsExampleGroup
  config.include ActionView::TestCase::Behavior, example_group: {file_path: %r{spec/procedures}}
  config.include ActionView::TestCase::Behavior, example_group: {file_path: %r{spec/presenters}}
  config.infer_base_class_for_anonymous_controllers = false

  config.before(:each) {
    Rails.cache.clear rescue nil
  }
end

require 'support/global_helpers'
