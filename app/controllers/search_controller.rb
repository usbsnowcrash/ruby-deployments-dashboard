require 'net/http'
require 'net/https'
require 'json'
require 'httparty'

class SearchController < ApplicationController
  def index
  end

  def compare
      url = 'http://api.careerbuilder.com/v1/jobsearch?outputjson=true&' + params["leftside"]
      resp = Net::HTTP.get_response(URI.parse(url))
      @apiresponseleft = JSON.parse(resp.body)["ResponseJobSearch"]["Results"]

      url2 = 'http://api.careerbuilder.com/v1/jobsearch?outputjson=true&' + params["rightside"]
      resp2 = Net::HTTP.get_response(URI.parse(url2))
      @apiresponseright = JSON.parse(resp2.body)["ResponseJobSearch"]["Results"]

  end
end
