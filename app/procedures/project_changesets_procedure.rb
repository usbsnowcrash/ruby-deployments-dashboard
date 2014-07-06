class ProjectChangesetsProcedure < BaseProcedure
  ViewData = Struct.new(:this_pull, :commits)

  def view_data
    this_pull = github.pull_requests.get(user: 'cbdr', repo: @params[:repo_name], number: @params[:pull_id])
    commits = github.pull_requests.commits(user: 'cbdr', repo: @params[:repo_name], number: @params[:pull_id])
    ViewData.new(this_pull, commits.select{ |i| i.commit.message.downcase.include?('pull request')})
  end

  private

  def github
    Github.new do |config|
      config.oauth_token = ENV['GITHUB_TOKEN']
      config.org = 'cbdr'
      config.auto_pagination = true
    end
  end
end
