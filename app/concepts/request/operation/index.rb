class Request
  class Index < ::Application::Operation
    step :model!

    def model!(options, **)
      options['model'] = Request.active.order(created_at: :desc)
    end
  end
end
