require File.expand_path('../boot', __FILE__)

# require 'rails/all'
require 'action_controller/railtie'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'
require 'dotenv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv.load

module RubyDeploymentsDashboard
  class Application < Rails::Application
    # config.active_record.raise_in_transactional_callbacks = true
    #
  end
end
