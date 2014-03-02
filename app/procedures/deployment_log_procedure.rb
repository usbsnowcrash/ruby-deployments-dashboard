require 'services/pull_request_service'

class DeploymentLogProcedure < BaseProcedure
  ViewData = Struct.new(:pulls)

  def view_data
    ViewData.new Services::PullRequestService.new(pulls_request).pull_requests
  end

  private

  def pulls_request
    Services::Requests::PullsRequest.new('cbdr', 'CB-Mobile', 'closed', 'production')
  end
end
