# frozen_string_literal: true

module RenderHelper
  def render_view(action = action_name, options = {})
    fetch_operation_result!(options)
    render_flashes!(options.delete(:flashes) || operation_flashes)
    render html: cell(cell_class(action, options), options.delete(:model) || cell_model,
                      layout: options.delete(:layout) || ::Layout::Cell::Application::Light,
                      context: options)
  end

  private

  attr_reader :op_result

  def fetch_operation_result!(options)
    @op_result = options.delete(:result) || result
  end

  def render_flashes!(flashes)
    flash.now.alert = flashes[:alert] if flashes[:alert]
    flash.now.notice = flashes[:notice] if flashes[:notice]
  end

  def operation_flashes
    (op_result && op_result['alerts']) || {}
  end

  def cell_class(action, options)
    options.delete(:cell) ||
      "#{controller_name.classify}::Cell::#{action.to_s.classify}".constantize
  end

  def cell_model
    @form.presence || @model
  end
end
