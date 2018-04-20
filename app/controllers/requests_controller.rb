class RequestsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    run Request::Index
    render_view
  end
end
