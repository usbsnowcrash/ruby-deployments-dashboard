module PullRequestsHelper
  def should_check_box(id)
    return false if !params[:teams].present?
    params[:teams].split(',').include?(id.to_s)
  end
end
