module Requests
  class ConfirmedController < ApplicationController
    def index
      run Request::Confirmed::Index do
        return render_view :index, cell: ::Request::Cell::WallIndex, layout: false
      end

      render_remote
    end

    def update
      run ::Request::Confirm

      redirect_to result['model'], result['alerts']
    end
  end
end
