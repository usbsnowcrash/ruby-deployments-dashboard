module PullRequestsHelper
  def should_check_box(id)
    return false unless params[:teams].present?
    params[:teams].split(',').include?(id.to_s)
  end

  def days_ago(pr_date)
    date_diff = (DateTime.now - DateTime.parse(pr_date)).to_i
    if date_diff == 0
      'Today'
    else
      "#{date_diff} days ago"
    end
  end
end
