module Trailblazer
  class Operation
    class HandleAlerts
      extend Uber::Callable

      def self.call(options, **)
        AlertsHandler.call(options)
      end
    end
  end
end
