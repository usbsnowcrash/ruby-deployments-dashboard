class DeploymentsController < ApplicationController
  DetailsViewData = Struct.new(:this_pull, :commits)
  PullRequest = Struct.new(:user_login, :user_avatar, :title, :pull_number, :merged_at)

  def list
    @pulls = merged_pull_requests
    begin
      @diff = github_api.repos.commits.compare(user: params[:user_name], repo: params[:repo_name], base: 'master', head: 'production')
    rescue Github::Error::NotFound
      @diff = nil
    end
  end

  def details
    this_pull = github_api.pull_requests.get(user: params[:user_name], repo: params[:repo_name], number: params[:pull_id])
    commits = github_api.pull_requests.commits(user: params[:user_name], repo: params[:repo_name], number: params[:pull_id])
    @view_data = DetailsViewData.new(this_pull, commits.select { |i| i.commit.message.downcase.include?('pull request') })
  end

  private

  def merged_pull_requests
    pulls = []
    pull_requests.each do |pull|
      pulls << convert_to_pull_model(pull) unless pull.merged_at.nil?
    end
    pulls
  end

  def pull_requests
    github_api.pull_requests.all(user: params[:user_name], repo: params[:repo_name], state: 'closed', base: 'production')
  end

  def convert_to_pull_model(pull)
    PullRequest.new(pull.user.login,
                    pull.user.avatar_url,
                    pull.title,
                    pull.number,
                    pull.merged_at.in_time_zone('Eastern Time (US & Canada)').strftime('%m/%d/%Y | %I:%M %p EST'))
  end
end
