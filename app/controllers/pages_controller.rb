class PagesController < ApplicationController
  def home
    render_view :home, layout: ::Layout::Cell::Application::Dark
  end

  def about
    render_view
  end
end
