class ProjectChangesetsProcedure < BaseProcedure
  ViewData = Struct.new(:this_pull, :commits)

  def view_data
    thispull = github.pull_requests.get(user: 'cbdr', repo: @params[:repo_name], number: @params[:pull_id])
    commits = github.pull_requests.commits(user: 'cbdr', repo: @params[:repo_name], number: @params[:pull_id])

    ViewData.new(thispull, commits)
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
