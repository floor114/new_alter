module Trailblazer
  class Operation
    class AssignCurrentUser
      extend Uber::Callable

      def self.call(_ctx, model:, current_user:, **)
        model.user = current_user
      end
    end
  end
end
