module Services
  module Requests
    class PullsRequest < Struct.new(:user, :repo, :state, :base, :token); end
  end
end
