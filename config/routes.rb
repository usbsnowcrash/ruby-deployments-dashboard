Searchtester::Application.routes.draw do
  #get "", to: 'version#dashboard' , as: 'default'
  get "search", to: 'search#index'
  get "deployments/:id", to: 'version#index' , as: 'version'
  get "deployments/", to: 'version#dashboard' , as: 'deployments'
  post "search/compare"

  constraints(:host => /scrum.cbmtn.io/) do
    get '/', to: redirect {|p, req| "https://careerbuilder.mingle.thoughtworks.com/projects/" }
  end

  constraints(:host => /oncall.cbmtn.io/) do
    get '/', to: redirect {|p, req| "https://cbapi.pagerduty.com/" }
  end

  constraints(:host => /cloud.cbmtn.io/) do
    get '/', to: redirect {|p, req| "https://console.aws.amazon.com/elasticbeanstalk/home?region=us-east-1#/applications?applicationNameFilter="}
  end
end
