module Decisions
  class PartlyAcceptedController < ApplicationController
    def edit
      run ::Decision::PartlyAccept::Present do
        return render_modal :partly_accepted, prepopulate: true
      end

      redirect_to model, result['alerts']
    end

    def update
      run ::Decision::PartlyAccept do |result|
        return render_remote result: result, location: decisions_path
      end

      render_remote
    end
  end
end
