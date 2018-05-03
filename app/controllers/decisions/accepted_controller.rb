module Decisions
  class AcceptedController < ApplicationController
    def update
      run ::Decision::Accept

      redirect_to result['model'], result['alerts']
    end
  end
end
