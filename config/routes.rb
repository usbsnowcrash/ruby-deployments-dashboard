RubyDeploymentsDashboard::Application.routes.draw do
  root 'home#index'

  get 'oauth/authorize', to: 'oauth#authorize', as: :oauth_authorize
  get 'oauth/token', to: 'oauth#token', as: :oauth_token
  get 'oauth/destroy', to: 'oauth#destroy', as: :oauth_destroy
  get 'deployments', to: 'deployments#list', as: 'list'
  get 'deployments/:user_name/:repo_name/:pull_id', to: 'deployments#index', as: 'pull_request'
  get 'deployments/:user_name/:repo_name', to: 'deployments#dashboard', as: 'deployments'
end
