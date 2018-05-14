module Trailblazer
  class Operation
    class Destroy
      extend Uber::Callable

      def self.call(_ctx, model:, **)
        model.destroy
      end
    end
  end
end
