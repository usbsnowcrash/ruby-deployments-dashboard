class OauthController < ApplicationController
  skip_before_filter :auth_check

  def authorize
    session.clear
    redirect_to github_api.authorize_url(redirect_uri: oauth_token_url, scope: 'user, repo')
  end

  def token
    token = github_api.get_token(params[:code])
    session[:token] = token.token
    user = Github.new(oauth_token: session[:token]).users.get
    session[:avatar] = user.avatar_url
    session[:login] = user.login
    session[:url] = user.html_url
    redirect_to root_url
  end

  def destroy
    session.clear
    redirect_to root_url
  end

  private

  def github_api
    Github.new client_id: ENV['CLIENT_ID'], client_secret: ENV['CLIENT_SECRET']
  end
end
