class Message
  class Request
    class Cell
      class Index < ::Application::Cell
        def new_message
          @new_message ||= ::Message.new(receiver: receiver)
        end

        def receiver
          ::Request.find_by(id: params[:request_id])
        end
      end
    end
  end
end
