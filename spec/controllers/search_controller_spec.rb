require 'spec_helper'

describe SearchController do
  let(:view_data) {Struct.new(:api_result_left, :api_result_right)}
  let(:successful_compare) { view_data.new(nil,nil)}

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "#compare" do
    let(:params){ Hash.new }
    it "returns http success" do
      SearchCompareProcedure.any_instance.stub(:view_data).and_return(successful_compare)
      expect(post :compare, params).to render_template(:compare)
    end
  end

end
