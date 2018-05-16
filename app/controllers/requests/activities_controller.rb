module Requests
  class ActivitiesController < ApplicationController
    def index
      run ::Activity::Request::Index do
        return render_view :index, cell: ::Activity::Request::Cell::Index, layout: false
      end

      render_remote
    end
  end
end
