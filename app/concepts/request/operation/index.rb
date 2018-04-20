class Request
  class Index < ::Application::Operation
    step :model!

    def model!(ctx, **)
      ctx['model'] = Request.active.order(created_at: :desc)
    end
  end
end
