class UsersController < ApplicationController
  def index
    run User::Index do
      return render_view
    end

    redirect_to root_path, result['alerts']
  end

  def show
    run User::Show do
      return render_view
    end

    redirect_to root_path, result['alerts']
  end
end
