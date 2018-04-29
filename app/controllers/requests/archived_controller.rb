module Requests
  class ArchivedController < ApplicationController
    def update
      run ::Request::Archive

      redirect_to result['model'], result['alerts']
    end
  end
end
