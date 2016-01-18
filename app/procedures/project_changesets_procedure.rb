class ProjectChangesetsProcedure < BaseProcedure
  ViewData = Struct.new(:this_pull, :commits)

  def view_data
    this_pull = github.pull_requests.get(user: @params[:user_name], repo: @params[:repo_name], number: @params[:pull_id])
    commits = github.pull_requests.commits(user: @params[:user_name], repo: @params[:repo_name], number: @params[:pull_id])
    ViewData.new(this_pull, commits.select { |i| i.commit.message.downcase.include?('pull request') })
  end

  private

  def github
    Github.new do |config|
      config.oauth_token = @session[:token]
      config.org = @params[:user_name]
      config.auto_pagination = true
      config.client_id = ENV['CLIENT_ID']
      config.client_secret = ENV['CLIENT_SECRET']
    end
  end
end
