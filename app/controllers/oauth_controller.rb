class OauthController < ApplicationController
  skip_before_filter :auth_check

  def authorize
    redirect_to github_api.authorize_url(redirect_uri: oauth_token_url, scope: 'user, repo')
  end

  def token
    @token = github_api.get_token(params[:code])
    @user = github_api.users.get(oauth_token: @token.token)
    @teams = github_api.orgs.teams.list(oauth_token: @token.token)
    url = determine_next_url
    build_session
    redirect_to url
  rescue OAuth2::Error
    flash[:notice] = 'Error during login'
    redirect_to oauth_destroy_path
  end

  def destroy
    session.clear
    session[:next] = params[:next]
    redirect_to root_url
  end

  private

  def clear_session
    next_url = session[:next]
    reset_session
    session[:next] = next_url unless next_url.present?
  end

  def determine_next_url
    if session[:next].present?
      session[:next]
    else
      root_url
    end
  end

  def build_session
    session[:token] = @token.token
    session[:avatar] = @user.avatar_url
    session[:login] = @user.login
    session[:url] = @user.html_url
    session[:teams] = []
    @teams.each do |team|
      session[:teams] << team[:id]
    end
    session.delete(:next)
  end
end
