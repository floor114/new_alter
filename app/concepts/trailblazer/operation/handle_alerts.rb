module Trailblazer
  class Operation
    class HandleAlerts
      extend Uber::Callable

      def self.call(context, **)
        AlertsHandler.call(context)
      end
    end
  end
end
