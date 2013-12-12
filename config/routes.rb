Searchtester::Application.routes.draw do
  get "search/index"
  post "search/compare"

  constraints(:host => /scrum.cbmtn.io/) do
    get '/', to: redirect {|p, req| "https://careerbuilder.mingle.thoughtworks.com/projects/" }
  end

  constraints(:host => /oncall.cbmtn.io/) do
    get '/', to: redirect {|p, req| "https://cbapi.pagerduty.com/" }
  end
end
