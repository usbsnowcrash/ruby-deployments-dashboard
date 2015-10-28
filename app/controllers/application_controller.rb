class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :auth_check

  def auth_check
    redirect_to oauth_authorize_path unless session[:token].present?
  end
end
