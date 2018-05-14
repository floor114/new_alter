class Message
  class Request
    class Cell
      class Form < ::Application::Cell
        def new_message
          @new_message ||= ::Message::Request::Contract::Create.new(model)
        end
      end
    end
  end
end
