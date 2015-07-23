module Capybara
  class Session
    def wait_until_path_eq(path)
      wait_until do
        current_path_with_qs == path
      end
    end

    def wait_until_path_not_eq(path)
      wait_until do
        current_path_with_qs != path
      end
    end

    def wait_until(timeout = Capybara.default_wait_time, &block)
      start = Time.now
      loop do
        break if block.call
        if Time.now > start + timeout
          fail "Expected condition failed: \n#{block.source}"
        end
        sleep 0.1
      end
    end

    private

    def current_path_with_qs
      uri = URI.parse(current_url)
      "#{uri.path}?#{uri.query}"
    end
  end
end
