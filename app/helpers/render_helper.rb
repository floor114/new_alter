module RenderHelper
  def render_view(action = action_name, options = {})
    render html: cell(cell_class(action, options), options.fetch(:model, :cell_model),
                      layout: options.fetch(:layout, ::Layout::Cell::Application::Light),
                      context: options.except(:layout, :model, :result, :cell))
  end

  private

  def cell_class(action, options)
    options[:cell] || "#{controller_name.classify}::Cell::#{action.to_s.classify}".constantize
  end
end
