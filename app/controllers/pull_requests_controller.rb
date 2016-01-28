class PullRequestsController < ApplicationController
  PullRequest = Struct.new(:user_login, :user_avatar, :title, :pull_number, :url, :created_at)

  def index
    @teams = github_api.orgs.teams.list
    @pulls = []
    gather_pull_requests if params[:teams].present?
  end

  private

  def gather_pull_requests
    repos = []

    params[:teams].split(',').each do |team_id|
      repos += repos(team_id)
    end

    open_issues = []
    repos.each do |repo|
      open_issues << repo if repo[:open_issues_count] > 0
    end

    open_issues.each do |issue|
      pull_requests(issue[:owner][:login], issue[:name]).each do |pull|
        @pulls << convert_to_pull_model(pull)
      end
    end
  end

  def repos(team_id)
    github_api.orgs.teams.repos(team_id)
  end

  def pull_requests(user, repo)
    github_api.pull_requests.all(user: user, repo: repo, state: 'open')
  end

  def convert_to_pull_model(pull)
    PullRequest.new(pull.user.login,
                    pull.user.avatar_url,
                    pull.title,
                    pull.number,
                    pull.url.gsub('api.github','www.github'),
                    pull.created_at.in_time_zone('Eastern Time (US & Canada)').strftime('%m/%d/%Y | %I:%M %p EST'))
  end

end
