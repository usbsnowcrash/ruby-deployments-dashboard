require 'spec_helper'

describe SearchController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'compare'" do
    it "returns http success" do
      get 'compare'
      response.should be_success
    end
  end

end
