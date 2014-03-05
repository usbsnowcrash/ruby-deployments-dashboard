require 'spec_helper'
require 'support/mocks/mock_github_pull_request'
require 'services/requests/pulls_request'

module Services::ApiAdapters
  describe GithubPullRequestAdapter do
    context 'When passed a bad request' do
      it 'raises an exception' do
        expect{Services::ApiAdapters::GithubPullRequestAdapter.new nil}.to raise_exception
      end
    end

    context 'When passed a valid request' do
      let(:good_request){Services::Requests::PullsRequest.new 'cbdr', 'CB-Mobile', 'closed', 'production'}
      let(:adapter) {Services::ApiAdapters::GithubPullRequestAdapter.new good_request}

      it 'does not raise an exception' do
        expect{adapter}.not_to raise_exception
      end

      it 'calls the github api with the correct parameters' do
        Github::PullRequests.any_instance.should_receive(:all).with do |criteria|
          criteria[:user].should == 'cbdr'
          criteria[:repo].should == 'CB-Mobile'
          criteria[:state].should == 'closed'
          criteria[:base].should == 'production'
        end.and_return Hash.new
        adapter.merged_pull_requests
      end

      context 'and we find results' do
        it 'converts them to our model' do
          Github::PullRequests.any_instance.stub(:all).and_return MockGithubPullRequest.merged_pulls
          pulls = adapter.merged_pull_requests
          pulls.count.should == 2
          pulls[0].user_login.should == 'lance_hardwood'
          pulls[0].user_avatar.should == 'http://a.b.com/lance.jpg'
          pulls[0].title.should == 'title1'
          pulls[0].pull_number.should == 1
        end
      end

      context 'and we find some results that are not merged' do
        it 'returns only the merged pull requests' do
          Github::PullRequests.any_instance.stub(:all).and_return  MockGithubPullRequest.mixed_list
          pulls = adapter.merged_pull_requests
          pulls.count.should == 1
        end
      end

      context 'and we dont find results' do
        it 'returns an empty list' do
          Github::PullRequests.any_instance.stub(:all).and_return Hash.new
          adapter.merged_pull_requests.count.should == 0
        end
      end
    end

  end
end
