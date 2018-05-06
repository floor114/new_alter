module Requests
  class ArchivedController < ApplicationController
    def index
      run Request::Archived::Index do
        return render_view :index, cell: ::Request::Cell::WallIndex, layout: false
      end

      render_remote
    end

    def update
      run ::Request::Archive

      redirect_to result['model'], result['alerts']
    end
  end
end
