class DecisionsController < ApplicationController
  def index
    run Decision::Index do
      return render_view
    end

    redirect_to root_path, result['alerts']
  end

  def show
    run Decision::Show do
      return render_view
    end

    redirect_to decisions_path, result['alerts']
  end

  def new
    run ::Decision::Create::Present do
      return render_modal :new, prepopulate: true
    end

    redirect_to model.request, result['alerts']
  end

  def create
    run ::Decision::Create do |result|
      return render_remote result: result, location: model.request
    end

    render_remote
  end
end
