class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
    render_view :home, layout: ::Layout::Cell::Application::Dark
  end

  def about
    render_view
  end
end
