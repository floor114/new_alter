module Requests
  class DeclinedController < ApplicationController
    def update
      run ::Request::Decline

      redirect_to result['model'], result['alerts']
    end
  end
end
