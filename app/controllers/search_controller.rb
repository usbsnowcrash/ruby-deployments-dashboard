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

  def stupid
    url = 'https://api.github.com/repos/cbdr/CB-Mobile/pulls?state=closed&base=production&access_token=15d13e3ca0aa8c8e8f5d9174d48e1b995b5d7450'
    resp = HTTParty.get(url, :headers => {"User-Agent" => 'ruby'})
    @pulls = JSON.parse(resp.body)
  end

  def version
    url = 'https://api.github.com/repos/cbdr/CB-Mobile/pulls?state=closed&base=production&access_token=15d13e3ca0aa8c8e8f5d9174d48e1b995b5d7450'
    resp = HTTParty.get(url, :headers => {"User-Agent" => 'ruby'})
    @pulls = JSON.parse(resp.body)
  end
end
