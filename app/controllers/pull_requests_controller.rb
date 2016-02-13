class PullRequestsController < ApplicationController
  PullRequest = Struct.new(:user_login, :user_avatar, :title, :pull_number, :url, :created_at, :repo_name)

  def index
    @teams = github_api.orgs.teams.list.sort_by { |team| team.name.downcase }
    @pulls = []
    gather_pull_requests if show_pr_section?
  end

  def create
    @diff = github_api.repos.commits.compare(user: params[:user_name], repo: params[:repo_name], base: 'production', head: 'master')
    pr_titles = []
    @diff[:commits].each do |commit|
      pr_titles.push commit.commit[:message].split("\n\n")[1] if commit.commit[:message].start_with?('Merge pull request #')
    end
    begin
      github_api.pull_requests.create(user: params[:user_name], repo: params[:repo_name],
                                      title: pr_titles.join('; '), body: '',
                                      head: 'master', base: 'production')
    rescue Github::Error::UnprocessableEntity

    end
    redirect_to github_api.pull_requests.all(user: params[:user_name], repo: params[:repo_name], state: 'open', base: 'production')[0][:html_url]
  end

  def show_pr_section?
    params[:teams].present?
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
    @pulls.sort_by!(&:created_at)
  end

  def repos(team_id)
    github_api.orgs.teams.repos(team_id).select { |repo| repo[:fork] == false }
  end

  def pull_requests(user, repo)
    github_api.pull_requests.all(user: user, repo: repo, state: 'open')
  end

  def convert_to_pull_model(pull)
    PullRequest.new(pull.user.login,
                    pull.user.avatar_url,
                    pull.title,
                    pull.number,
                    pull.html_url,
                    pull.created_at,
                    pull.head.repo.name)
  end
end
