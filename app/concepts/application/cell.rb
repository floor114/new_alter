module Application
  class Cell < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Devise::Controllers::Helpers

    def data_disable_with
      { disable_with: t('views.actions.waiting') }
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
