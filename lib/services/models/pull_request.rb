module Services
  module Models
    class PullRequest < Struct.new(:user_login, :user_avatar, :title, :pull_number, :merged_at); end
  end
end