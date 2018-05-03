module Decisions
  class PartlyAcceptedController < ApplicationController
    def update
      run ::Decision::PartlyAccept

      redirect_to result['model'], result['alerts']
    end
  end
end
