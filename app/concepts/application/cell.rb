# frozen_string_literal: true

# TODO: refactor base cell

module Application
  class Cell < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include ActionView::Helpers::CsrfHelper
    include ActionView::Helpers::FormOptionsHelper
    include ActionView::Helpers::NumberHelper
    include ActionView::Helpers::DateHelper
    include Devise::Controllers::Helpers
    include Cocoon::ViewHelpers
    include Pundit

    DESCRIPTION_LENGTH_IN_LIST = 530

    def data_disable_with
      { disable_with: t('views.actions.waiting') }
    end

    def data_confirm(key)
      { confirm: t(key, scope: 'views.messages.confirmation') }
    end

    def page_title
      t("views.titles.#{controller_path}.#{params[:action]}", default: controller_title)
    end

    def list_block(relation = model)
      return empty_block if relation.blank?

      cell(
        "::#{self.class.name.split('::Cell').first}::Cell::List".constantize,
        collection: relation
      )
    end

    def list?
      options[:list].present?
    end

    def policy?(action, record = model)
      policy(record).send("#{action}?")
    end

    def description_block
      return truncated_description_block if list?

      simple_format(description, class: 'description')
    end

    def link_to_allowed(name = nil, options = nil, html_options = nil, &block)
      custom_options = block_given? ? options : html_options

      return unless policy?(custom_options.delete(:action), custom_options.delete(:record) || model)

      link_to(name, options, html_options, &block)
    end

    private

    def truncated_description_block
      content_tag(:p, truncated_description, class: 'description description-list')
    end

    def truncated_description
      @truncated_description ||= description.truncate(DESCRIPTION_LENGTH_IN_LIST, separator: ' ')
    end

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
