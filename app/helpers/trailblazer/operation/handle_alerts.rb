module Trailblazer
  class Operation
    class HandleAlerts
      extend Uber::Callable

      def self.call(ctx, **)
        AlertsHandler.call(ctx)
      end
    end
  end
end
