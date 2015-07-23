require 'spec_helper'
require 'services/compare_searches_service'
require 'services/requests/search_comparison_request'

module Services
  describe CompareSearchesService do
    let(:example_request) { Services::Requests::SearchComparisonRequest.new 'everything_thing=overrated', 'will_i_wake_up=with_all_the_answers' }
    context 'When run searches is called' do
      it 'we pass the correct values from the request' do
        Net::HTTP.stub(:get_response).and_return 'json_string'

        svc = Services::CompareSearchesService.new example_request
        #         Services::ApiAdapters::CbUserApiAdapter.should_receive(:new).with do |criteria|
        #           criteria.email.should == request.email
        #           criteria.password.should == request.password
        #         end.and_return(dummy)
        #
        #         svc.sign_in
      end
    end
  end
end
