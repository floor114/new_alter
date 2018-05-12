# frozen_string_literal: true

# TODO: Refactor render helper

module RenderHelper
  def render_view(action = action_name, options = {})
    fetch_operation_result!(options)
    render_flashes!(options.delete(:flashes) || operation_flashes)
    render html: cell(cell_class(action, options), options.delete(:model) || cell_model(options),
                      layout: choose_layout(options),
                      context: options)
  end

  def render_modal(action = action_name, options = {})
    render_view(action, options.merge(layout: ::Layout::Cell::Modal))
  end

  def render_remote(options = {})
    fetch_operation_result!(options)
    render_flashes!(operation_flashes, !options[:location])

    render json: operation_flashes,
           status: op_result['status'],
           location: options.delete(:location)
  end

  private

  attr_reader :op_result

  def fetch_operation_result!(options)
    @op_result = options.delete(:result) || result
  end

  def render_flashes!(flashes, now = true)
    flash_instance = now ? flash.now : flash

    flash_instance.alert = flashes[:alert] if flashes[:alert]
    flash_instance.notice = flashes[:notice] if flashes[:notice]
  end

  def operation_flashes
    (op_result && op_result['alerts']) || {}
  end

  def cell_class(action, options)
    options.delete(:cell) ||
      "#{controller_name.classify}::Cell::#{action.to_s.classify}".constantize
  end

  def cell_model(options)
    @form.presence.tap do |form|
      return @model if form.blank?

      form.prepopulate! if options.delete(:prepopulate)
    end
  end

  def choose_layout(options)
    options.delete(:layout).tap do |layout|
      return ::Layout::Cell::Application::Light if layout.nil?
    end
  end
end
