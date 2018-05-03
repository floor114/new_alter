module Decisions
  class RejectedController < ApplicationController
    def update
      run ::Decision::Reject

      redirect_to result['model'], result['alerts']
    end
  end
end
