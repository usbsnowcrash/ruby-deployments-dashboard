class HomeController < ApplicationController
  skip_before_filter :auth_check

  def index
    @teams = []
    if session[:token].present?
      @teams = github_api.orgs.teams.list
    end
  end
end
