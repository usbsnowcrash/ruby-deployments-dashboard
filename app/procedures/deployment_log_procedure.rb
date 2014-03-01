class DeploymentLogProcedure < BaseProcedure
  ViewData = Struct.new(:pulls)

  def view_data
    unfiltered_pulls = github.pull_requests.all(:user => 'cbdr', :repo => 'CB-Mobile', :state => 'closed', :base => 'production')
    pulls = []
    unfiltered_pulls.each do |pull|
      pulls << pull if pull.merged_at.nil? == false
    end

    ViewData.new pulls
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
