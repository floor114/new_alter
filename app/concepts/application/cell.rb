module Application
  class Cell < Trailblazer::Cell
    include ActionView::Helpers::TranslationHelper
    include Devise::Controllers::Helpers

    def data_disable_with
      { disable_with: t('views.actions.waiting') }
    end
  end
end
