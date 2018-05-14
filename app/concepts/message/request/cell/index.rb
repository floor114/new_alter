class Message
  class Request
    class Cell
      class Index < ::Application::Cell
        def new_message_form
          return unless policy?(:request_create, Message)

          cell(::Message::Request::Cell::Form, ::Message.new)
        end
      end
    end
  end
end
