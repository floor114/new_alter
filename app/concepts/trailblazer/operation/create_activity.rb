# frozen_string_literal: true

module Trailblazer
  class Operation
    def self.CreateActivity(action:, **)
      step = CreateActivity.new(action)

      [step, name: 'create_activity']
    end

    class CreateActivity
      def initialize(action)
        @action = action
      end

      def call(_ctx, model:, current_user:, **)
        model.create_activity(action, owner: current_user)
      end

      private

      attr_reader :action
    end
  end
end
