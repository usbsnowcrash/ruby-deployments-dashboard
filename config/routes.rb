Rails.application.routes.draw do
  get 'oauth/authorize'
  get 'oauth/token'
  get 'oauth/destroy'
  get 'deployments/list'
  get 'deployments/:user_name/:repo_name/:pull_id', to: 'deployments#details', as: 'deployments_details'

  root 'home#index'
end
