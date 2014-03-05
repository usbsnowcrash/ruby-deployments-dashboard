class SearchController < ApplicationController
  def index
  end

  def compare
    @view_data = SearchCompareProcedure.new(self,params,session).view_data
  end
end
