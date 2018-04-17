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
      end
    end
  end
end
