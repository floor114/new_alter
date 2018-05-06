# frozen_string_literal: true

module Trailblazer
  class Operation
    def self.Finder(finder_class, action, entity_type)
      step = Finder.new(finder_class, action, entity_type)

      [step, name: 'finder']
    end

    class Finder
      def initialize(*args)
        @builder = Finder::Builder.new(*args)
      end

      def call(options, params:, **)
        finder = @builder.call(options, params)
        options['finder'] = finder
        options['model'] = finder&.results

        Result.new(finder.present?, {})
      end

      class Builder
        ACTIONS = [
          ALL = :all,
          SINGLE = :single
        ].freeze

        def initialize(finder_class, action = nil, entity_type = nil)
          @finder_class = finder_class
          @action = ACTIONS.include?(action) ? action : ALL
          @entity_type = entity_type
        end

        def call(options, params)
          normalize_params!(options, params)
          send("#{@action}!", @finder_class, @entity_type, params, @action)
        end

        private

        def normalize_params!(options, params)
          params[:f] ||= {}

          options['finder.keys']&.each do |key|
            value = params.delete(key)
            params[:f][key] = value if value.present?
          end
        end
      end
    end
  end
end
