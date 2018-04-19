class UsersController < ApplicationController
  def show
    run User::Show do |result|
      return render_view :show, result: result
    end

    redirect_to root_path, result['alerts']
  end
end
