class OauthController < ApplicationController
  skip_before_filter :auth_check

  def authorize
    reset_session
    redirect_to github_api.authorize_url(redirect_uri: oauth_token_url, scope: 'user, repo')
  end

  def token
    begin
      @token = github_api.get_token(params[:code])
      @user = github_api.users.get(oauth_token: @token.token)
      @teams = github_api.orgs.teams.list(oauth_token: @token.token)
      build_session
      redirect_to root_url
    rescue OAuth2::Error
      flash[:notice] = 'Error during login'
      redirect_to oauth_destroy_path
    end


  end

  def destroy
    session.clear
    redirect_to root_url
  end

  private

  def build_session
    session[:token] = @token.token
    session[:avatar] = @user.avatar_url
    session[:login] = @user.login
    session[:url] = @user.html_url
    session[:teams] = []
    @teams.each do |team|
      session[:teams] << team[:id]
    end
  end

end
