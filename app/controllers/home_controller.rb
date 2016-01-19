class HomeController < ApplicationController
  skip_before_filter :auth_check
  def index
    @teams = github_teams if session[:token].present?
  end

  def github_teams
    github_api.orgs.teams.list
  end

  def github_api
    Github.new do |config|
      config.oauth_token = session[:token]
      config.auto_pagination = true
    end
  end

end
