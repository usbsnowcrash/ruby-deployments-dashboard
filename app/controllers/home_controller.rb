require 'pry'
class HomeController < ApplicationController
  skip_before_filter :auth_check

  def index
    @teams = []
    @repos = []
    if session[:token].present?
      @teams = github_api.orgs.teams.list.sort_by { |team| team.name.downcase }
      @repos = github_api.repos.list.select do |repo|
        repo['owner']['type'] == 'User' ||
            !@teams.collect { |t| t['organization']['login'] }.include?(repo['owner']['login'])
      end.sort_by { |repo| repo[:full_name].downcase }
    end
  end
end
