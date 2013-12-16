require 'github_api'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def github
    Github.new do |config|
      config.oauth_token = '15d13e3ca0aa8c8e8f5d9174d48e1b995b5d7450'
      config.org = 'cbdr'
      config.auto_pagination = true
    end
  end
end
