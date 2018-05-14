module Requests
  class MessagesController < ApplicationController
    skip_before_action :authenticate_user!, only: :index

    def index
      run ::Message::Request::Index do
        return render_view :index, cell: ::Message::Request::Cell::Index, layout: false
      end

      render_remote
    end

    def create
      run ::Message::Request::Create do |result|
        return render_remote result: result, location: model.receiver
      end

      render_remote
    end

    def destroy
      run ::Message::Request::Destroy do |result|
        return render_remote result: result
      end

      render_remote
    end
  end
end
