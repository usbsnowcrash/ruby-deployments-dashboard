class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :auth_check

  def auth_check
    redirect_to oauth_authorize_path unless session[:token].present?
  end

  private

  def github_api
    Github.new do |config|
      config.oauth_token ||= session[:oauth_token] ||= params[:oauth_token]
      config.org = params[:orgination] if params[:orgination].present?
      config.client_id = ENV['CLIENT_ID']
      config.client_secret = ENV['CLIENT_SECRET']
      config.auto_pagination = true
    end
  end
end
