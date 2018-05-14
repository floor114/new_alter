class Message
  class Request
    module Contract
      class Create < Reform::Form
        model Message

        properties :body

        validates :body, presence: true
      end
    end
  end
end
