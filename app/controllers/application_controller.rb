class ApplicationController < ActionController::Base
  force_ssl if Rails.env.production?

  protect_from_forgery with: :exception
end
