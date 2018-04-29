module Application
  class Operation < Trailblazer::Operation
    include ActionView::Helpers::TranslationHelper
    extend Trailblazer::Step::Finally
  end
end
