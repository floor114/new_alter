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

  def new
    run ::Request::Create::Present
    render_view
  end

  def create
    run ::Request::Create do |result|
      return redirect_to result['model']
    end
    render_view :new
  end

  def edit
    run ::Request::Update::Present
    render_view
  end

  def update
    run ::Request::Update do |result|
      return redirect_to result['model']
    end
    render_view :edit
  end
end
