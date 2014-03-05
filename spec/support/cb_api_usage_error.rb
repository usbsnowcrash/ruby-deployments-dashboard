module Cb
  module Utils
    class Api
      def cb_get(*args, &block)
        raise_not_stubbed_error(*args)
      end

      def cb_post(*args, &block)
        raise_not_stubbed_error(*args)
      end

      def cb_get_secure(*args, &block)
        raise_not_stubbed_error(*args)
      end

      private

      def raise_not_stubbed_error(*args)
        raise "An attempt to call the CB API endpoint, #{args[0]}, was made. You need to stub out the API call!"
      end

    end
  end
end