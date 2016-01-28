Rails.application.routes.draw do
  get 'oauth/authorize'
  get 'oauth/token'
  get 'oauth/destroy'
  get 'deployments/:user_name/:repo_name', to: 'deployments#list', as: 'deployments'
  get 'deployments/:user_name/:repo_name/:pull_id', to: 'deployments#details', as: 'deployments_details'

  root 'home#index'
end
