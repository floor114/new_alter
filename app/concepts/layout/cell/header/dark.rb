class Layout
  class Cell
    module Header
      class Dark < ::Application::Cell
        def show
          render :header
        end

        def theme_style
          :dark
        end

        # TODO: Delete dummy methods

        def user_signed_in?
          true
        end

        def current_user
          @current_user ||= OpenStruct.new(name: 'Taras Shpachenko')
        end
      end
    end
  end
end
