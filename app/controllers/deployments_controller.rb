class DeploymentsController < ApplicationController
  before_action :set_branch_name

  DetailsViewData = Struct.new(:this_pull, :commits)
  PullRequest = Struct.new(:user_login, :user_avatar, :title, :pull_number, :merged_at, :rollback_commit)

  def list
    @behind_by = 0
    @pr_titles = []
    @pulls = merged_pull_requests
    begin
      @diff = github_api.repos.commits.compare(user: params[:user_name], repo: params[:repo_name], base: @branch, head: 'master')
      @diff[:commits].each do |commit|
        if commit.commit[:message].start_with?('Merge pull request #')
          @behind_by += 1
          number = commit.commit[:message].match(/\#(\d+)/)
          @pr_titles << { title: commit.commit[:message].split("\n\n")[1], number: number[1] }
        end
      end
    rescue Github::Error::NotFound
      @diff = nil
    end
  end

  def details
    this_pull = github_api.pull_requests.get(user: params[:user_name], repo: params[:repo_name], number: params[:pull_id])
    commits = github_api.pull_requests.commits(user: params[:user_name], repo: params[:repo_name], number: params[:pull_id])
    @view_data = DetailsViewData.new(this_pull, commits)
  end

  def rollback;end

  private

  def set_branch_name
    branches = github_api.repos(user: params[:user_name], repo: params[:repo_name]).branches.list.to_a.map{ |r| r['name'] }
    @branch = branches.include?('production') ? 'production' : 'master'
  end

  def merged_pull_requests
    pulls = []
    pull_requests.each do |pull|
      pulls.last.rollback_commit = pull.head.sha unless pulls.last.nil?
      pulls << convert_to_pull_model(pull) unless pull.merged_at.nil?
    end
    pulls
  end

  def pull_requests
    github_api.pull_requests.all(user: params[:user_name], repo: params[:repo_name], state: 'closed', base: @branch)
  end

  def convert_to_pull_model(pull)
    PullRequest.new(pull.user.login,
                    pull.user.avatar_url,
                    pull.title,
                    pull.number,
                    pull.merged_at.in_time_zone('Eastern Time (US & Canada)').strftime('%m/%d/%Y | %I:%M %p EST'))
  end
end
