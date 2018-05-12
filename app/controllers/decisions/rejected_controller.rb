module Decisions
  class RejectedController < ApplicationController
    def update
      run ::Decision::Reject

      redirect_to decisions_path, result['alerts']
    end
  end
end
