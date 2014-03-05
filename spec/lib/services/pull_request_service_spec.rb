require 'spec_helper'
require 'services/pull_request_service'

module Services
  describe PullRequestService do
    let(:service){Services::PullRequestService.new(Services::Requests::PullsRequest.new('user', 'repo', 'state', 'base'))}
    context '#merged_pull_requests' do
      it 'constructs the adapter and passes the request to it' do
        Services::ApiAdapters::GithubPullRequestAdapter.should_receive(:new).with do |criteria|
          criteria.user.should == 'user'
          criteria.repo.should == 'repo'
          criteria.state.should == 'state'
          criteria.base.should == 'base'
        end.and_call_original
        Services::ApiAdapters::GithubPullRequestAdapter.any_instance.should_receive(:merged_pull_requests)
        service.merged_pull_requests
      end
    end
  end
end

