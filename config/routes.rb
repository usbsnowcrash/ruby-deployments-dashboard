Searchtester::Application.routes.draw do
  get "search", to: 'search#index'
  get "search/stupid", to: 'search#stupid'
  get "version/:id", to: 'version#index' , as: 'version'
  get "deployments/", to: 'version#dashboard' , as: 'deployments'
  post "search/compare"

  constraints(:host => /scrum.cbmtn.io/) do
    get '/', to: redirect {|p, req| "https://careerbuilder.mingle.thoughtworks.com/projects/" }
  end

  constraints(:host => /oncall.cbmtn.io/) do
    get '/', to: redirect {|p, req| "https://cbapi.pagerduty.com/" }
  end
end
