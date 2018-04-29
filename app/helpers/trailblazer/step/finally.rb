module Trailblazer
  module Step
    module Finally
      def finally(step_name)
        step step_name
        failure step_name
      end
    end
  end
end
