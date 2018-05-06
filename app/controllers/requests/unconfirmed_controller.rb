module Requests
  class UnconfirmedController < ApplicationController
    def index
      run Request::Unconfirmed::Index do
        return render_view :index, cell: ::Request::Cell::WallIndex, layout: false
      end

      render_remote
    end
  end
end
