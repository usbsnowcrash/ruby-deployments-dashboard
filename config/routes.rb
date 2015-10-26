Searchtester::Application.routes.draw do
  root 'home#index'

  get 'oauth/authorize', to: 'oauth#authorize', as: :oauth_authorize
  get 'oauth/token', to: 'oauth#token', as: :oauth_token
  get 'oauth/destroy', to: 'oauth#destroy', as: :oauth_destroy
  get 'deployments', to: 'version#index', as: 'dashboard'
  get 'deployments/:repo_name/:pull_id', to: 'version#index', as: 'version'
  get 'deployments/:repo_name', to: 'version#dashboard', as: 'deployments'
end
