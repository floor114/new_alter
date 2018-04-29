module Requests
  class ConfirmedController < ApplicationController
    def update
      run ::Request::Confirm

      redirect_to result['model'], result['alerts']
    end
  end
end
