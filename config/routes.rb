Rails.application.routes.draw do
  get 'repos/index'

  get 'pull_requests/index'

  get 'oauth/authorize'
  get 'oauth/token'
  get 'oauth/destroy'
  get 'repos/:team_id', to: 'repos#index', as: 'repos'
  get 'pull-requests', to: 'pull_requests#index', as: 'prs'
  get 'pull-requests/:teams', to: 'pull_requests#index', as: 'team_prs'
  get 'deployments/:user_name/:repo_name', to: 'deployments#list', as: 'deployments'
  get 'deployments/:user_name/:repo_name/:pull_id', to: 'deployments#details', as: 'deployments_details'
  get 'snacks', to: 'snacks#index', as: 'snacks'

  root 'home#index'
end
