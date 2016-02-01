class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :auth_check

  def auth_check
    redirect_to oauth_destroy_path unless session[:token].present? && member_of_team?
  end

  private

  def member_of_team?
    if ENV['REQUIRE_TEAM']
      session[:teams] && session[:teams].include?(ENV['REQUIRE_TEAM'].to_i)
    else
      true
    end
  end

  def github_api
    Github.new do |config|
      config.oauth_token ||= session[:token] ||= params[:oauth_token]
      config.org = params[:user_name] if params[:user_name].present?
      config.client_id = ENV['CLIENT_ID']
      config.client_secret = ENV['CLIENT_SECRET']
      config.auto_pagination = true
      #config.stack do |builder|
      #  builder.use Faraday::HttpCache, store: Rails.cache
      #end
    end
  end
end
