class Layout
  class Cell
    module Application
      class Dark < ::Application::Cell
        include ::ActionView::Helpers::CsrfHelper

        delegate :controller_name, to: :controller

        def action_assets_path(type)
          path = "#{[params[:controller], params[:action]].join('/')}.#{type}"
          ::Rails.application.assets.find_asset(path) ? path : ''
        end

        def general_assets_path(type)
          path = "#{params[:controller]&.split('/')&.first}.#{type}"
          ::Rails.application.assets.find_asset(path) ? path : ''
        end

        def page_title
          t("views.titles.#{controller_path}.#{params[:action]}", default: controller_title)
        end

        private

        def controller_title
          t("views.titles.#{controller_path}.all", default: t('views.app_name'))
        end

        def controller_path
          params[:controller]&.tr('/', '.')
        end
      end
    end
  end
end
