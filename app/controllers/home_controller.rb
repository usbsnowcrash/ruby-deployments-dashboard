class HomeController < ApplicationController
  def index
    @teams = []
    if session[:token].present?
      @teams = github_api.orgs.teams.list
    end
  end
end
