require 'services/pull_request_service'
require 'services/requests/pulls_request'

class DeploymentLogProcedure < BaseProcedure
  ViewData = Struct.new(:pulls)

  def view_data
    ViewData.new Services::PullRequestService.new(pulls_request).merged_pull_requests
  end

  private

  def pulls_request
    Services::Requests::PullsRequest.new('cbdr', 'CB-Mobile', 'closed', 'production')
  end
end
