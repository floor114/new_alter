require_dependency 'trailblazer/operation/create_activity'
require_dependency 'trailblazer/operation/finder'

module Application
  class Operation < Trailblazer::Operation
    include ActionView::Helpers::TranslationHelper
    extend Trailblazer::Step::Finally
  end
end
