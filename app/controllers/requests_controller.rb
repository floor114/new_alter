class RequestsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  impressionist actions: %i[show]

  def index
    run Request::Index do
      return render_view
    end

    redirect_to root_path, result['alerts']
  end

  def show
    run Request::Show do
      return render_view
    end

    redirect_to requests_path, result['alerts']
  end

  def new
    run ::Request::Create::Present do
      return render_view :new, prepopulate: true
    end

    redirect_to requests_path, result['alerts']
  end

  def create
    run ::Request::Create do
      return redirect_to model
    end

    render_view :new
  end

  def edit
    run ::Request::Update::Present do
      return render_view
    end

    redirect_to requests_path, result['alerts']
  end

  def update
    run ::Request::Update do
      return redirect_to model
    end

    render_view :edit
  end
end
