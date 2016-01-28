class SnacksController < ApplicationController
  def auth_check
    redirect_to oauth_authorize_path unless session[:token].present?
  end

  def index
  end
end
