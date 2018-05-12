# frozen_string_literal: true

class Decision
  module Contract
    class PartlyAccept < Reform::Form
      include Reform::Form::ModelReflections

      model Decision

      collection :accepted_items, form: ::AcceptedItem::Contract::PartlyAccept

      validates :accepted_items, presence: true
    end
  end
end
