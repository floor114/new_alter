# frozen_string_literal: true

class Request
  class Index < ::Application::Operation
    step :model!

    def model!(context, **)
      context['model'] = Request.active.order(created_at: :desc)
    end
  end
end
