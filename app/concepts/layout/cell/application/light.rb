class Layout
  class Cell
    module Application
      class Light < ::Application::Cell
        def share_this_url
          ENV['SHARE_THIS_URL']
        end
      end
    end
  end
end
