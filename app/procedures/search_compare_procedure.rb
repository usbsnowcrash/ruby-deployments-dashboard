require 'services/compare_searches_service'

class SearchCompareProcedure < BaseProcedure
  ViewData = Struct.new(:left_side_results, :right_side_results)

  def view_data
    svc = Services::CompareSearchesService.new compare_request
    results = svc.run_searches
    ViewData.new results.left_side_results, results.right_side_results
  end

  private

  def compare_request
    Services::Requests::SearchComparisonRequest.new params['leftside'],params['rightside']
  end

end
