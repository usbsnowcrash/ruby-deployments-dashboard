require 'spec_helper'

describe DeploymentLogProcedure do
  context '#view_data' do
    before {
      @procedure = DeploymentLogProcedure.new view, params, session
    }
    it 'calls PullRequestService looking for changes in CBMobile' do
      Services::PullRequestService.should_receive(:new).with do |criteria|
        criteria.user.should == 'cbdr'
        criteria.repo.should == 'CB-Mobile'
        criteria.state.should == 'closed'
        criteria.base.should == 'production'
      end.and_call_original
      Services::PullRequestService.any_instance.should_receive(:pull_requests)
      @procedure.view_data
    end
  end
end
