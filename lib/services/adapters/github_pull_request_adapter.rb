module Services
  module ApiAdapters
    class GithubPullRequestAdapter
      attr_reader :request

      def initialize(request)
        @request = request
        raise ArgumentError, 'Request can not be null' if request.nil?
      end

      def merged_pull_requests
        pulls = []
        pull_requests.each do |pull|
          pulls << convert_to_pull_model(pull) unless pull.merged_at.nil?
        end
        pulls
      end

      private

      def github_api
        Github.new do |config|
          config.oauth_token = ENV['GITHUB_TOKEN']
          config.org = @request.user
          config.auto_pagination = true
        end
      end

      def pull_requests
        github_api.pull_requests.all(:user => @request.user, :repo => @request.repo, :state => @request.state, :base => @request.base)
      end

      def convert_to_pull_model(pull)
        Services::Models::PullRequest.new(pull.user.login,
                                          pull.user.avatar_url,
                                          pull.title,
                                          pull.number,
                                          pull.merged_at.in_time_zone("Eastern Time (US & Canada)").strftime('%m/%d/%Y | %I:%M %p EST'))
      end
    end
  end
end
