module Wicked
  class ApplicationController < ::ApplicationController
    include Wicked::Wizard

    def render_step(the_step, options = {}, params = {})
      if the_step.nil? || the_step.to_s == Wicked::FINISH_STEP
        redirect_to_finish_wizard options, params
      else
        render_view the_step, options
      end
    end
  end
end
