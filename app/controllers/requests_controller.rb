class RequestsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    run Request::Index
    render_view
  end

  def show
    run Request::Show do |result|
      return render_view :show, result: result
    end

    redirect_to requests_path, result['alerts']
  end
end
