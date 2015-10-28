require 'parallel'
class HomeController < ApplicationController
  skip_before_filter :auth_check
  def index

  end
end
