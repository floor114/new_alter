module Requests
  class DeclinedController < ApplicationController
    def index
      run Request::Declined::Index do
        return render_view :index, cell: ::Request::Cell::WallIndex, layout: false
      end

      render_remote
    end

    def update
      run ::Request::Decline

      redirect_to result['model'], result['alerts']
    end
  end
end
