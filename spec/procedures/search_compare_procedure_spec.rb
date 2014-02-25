require 'spec_helper'
require 'services/responses/search_results'

describe SearchCompareProcedure do
  context 'when the user compares two api calls' do
    context 'and results are returned' do
      before {
        @procedure = SearchCompareProcedure.new view, params, session
        Services::CompareSearchesService.any_instance.stub(:run_searches).and_return search_results
        @view_data = @procedure.view_data
      }
      it 'returns the results in the view' do
        @view_data.should_not be_nil
        @view_data.left_side_results['hello'] == 'world'
        @view_data.left_side_results['goodbye'] == 'cruel world'
      end
    end
  end
end

private

def search_results
  Services::Responses::SearchResults.new({'hello' => 'world'}, {'goodbye' => 'cruel world'})
end

