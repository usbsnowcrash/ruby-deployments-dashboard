require 'services/adapters/github_pull_request_adapter'
module Services
  class PullRequestService
    def initialize(request)
      @request = request
    end

    def merged_pull_requests
      Services::ApiAdapters::GithubPullRequestAdapter.new(@request).merged_pull_requests
    end
  end
end
