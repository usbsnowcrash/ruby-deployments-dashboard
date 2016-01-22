class DeploymentsController < ApplicationController
  DetailsViewData = Struct.new(:this_pull, :commits)

  def list
  end

  def details
    this_pull = github_api.pull_requests.get(user: params[:user_name], repo: params[:repo_name], number: params[:pull_id])
    commits = github_api.pull_requests.commits(user: params[:user_name], repo: params[:repo_name], number: params[:pull_id])
    @view_data = ViewData.new(this_pull, commits.select { |i| i.commit.message.downcase.include?('pull request') })
  end
end
