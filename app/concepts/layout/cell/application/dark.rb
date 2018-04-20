class Layout
  class Cell
    module Application
      class Dark < ::Application::Cell
        include ::ActionView::Helpers::CsrfHelper

        delegate :controller_name, to: :controller

        def action_assets_path(type)
          path = "#{[params[:controller], params[:action]].join('/')}.#{type}"
          asset_available?(path) ? path : ''
        end

        def general_assets_path(type)
          path = "#{params[:controller]&.split('/')&.first}.#{type}"
          asset_available?(path) ? path : ''
        end

        private

        def asset_available?(path)
          if ::Rails.configuration.assets.compile
            ::Rails.application.precompiled_assets.include?(path)
          else
            ::Rails.application.assets_manifest.assets[path].present?
          end
        end
      end
    end
  end
end
