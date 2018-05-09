module Trailblazer
  module Reform
    module Nested
      extend ActiveSupport::Concern

      included do
        property :_destroy, virtual: true

        delegate :new_record?, :marked_for_destruction?, :mark_for_destruction, to: :model
      end
    end
  end
end
