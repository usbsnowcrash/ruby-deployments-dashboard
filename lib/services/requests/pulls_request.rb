module Services
  module Requests
    class PullsRequest < Struct.new(:user, :repo, :state, :base); end
  end
end
