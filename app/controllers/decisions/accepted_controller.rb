module Decisions
  class AcceptedController < ApplicationController
    def update
      run ::Decision::Accept

      redirect_to decisions_path, result['alerts']
    end
  end
end
