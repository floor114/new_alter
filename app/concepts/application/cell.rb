# frozen_string_literal: true

module Application
  class Cell < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include ActionView::Helpers::CsrfHelper
    include Devise::Controllers::Helpers
    include Pundit

    def data_disable_with
      { disable_with: t('views.actions.waiting') }
    end

    def page_title
      t("views.titles.#{controller_path}.#{params[:action]}", default: controller_title)
    end

    def list_block(relation = model)
      return empty_block if relation.blank?

      cell(
        "::#{relation.model_name.to_s.constantize}::Cell::List".constantize,
        collection: relation
      )
    end

    def list?
      options[:list].present?
    end

    def can?(action, record = model)
      policy(record).send("#{action}?")
    end

    private

    def controller_title
      t("views.titles.#{controller_path}.all", default: t('views.app_name'))
    end

    def controller_path
      params[:controller]&.tr('/', '.')
    end

    def empty_block
      content_tag(:p, t('errors.messages.nothing_to_show'), class: 'nothing-to-show')
    end
  end
end
