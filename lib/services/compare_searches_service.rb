# require 'services/adapters/cb_jobsearch_api_adapter'
require 'net/http'
require 'net/https'
require 'json'
require 'httparty'

module Services
  class CompareSearchesService
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def run_searches
      url_left = 'http://api.careerbuilder.com/v1/jobsearch?outputjson=true&' + @request.left_search
      url_right = 'http://api.careerbuilder.com/v1/jobsearch?outputjson=true&' + @request.right_search

      left_search_response = Net::HTTP.get_response(URI.parse(url_left))
      right_search_response = Net::HTTP.get_response(URI.parse(url_right))

      success_response left_search_response, right_search_response
    rescue Timeout::Error
      failed_response
    end

    private

    def success_response(left, right)
      response = Services::Responses::SearchResults.new
      response.left_side_results = JSON.parse(left.body)['ResponseJobSearch']['Results']
      response.right_side_results = JSON.parse(right.body)['ResponseJobSearch']['Results']
      response
    end

    def failed_response
      Services::Responses::SearchResults.new
    end
  end
end
