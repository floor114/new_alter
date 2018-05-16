# frozen_string_literal: true

module Trailblazer
  class Operation
    def self.Finder(finder_class, action, entity_type = nil)
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
          send("#{@action}!", @finder_class, @entity_type, params, options, @action)
        end

        private

        def all!(finder_class, entity_type, params, options, *)
          finder_class.new(
            entity_type: entity_type,
            filter: options['finder.params'],
            page: params[:page],
            per_page: params[:per_page]
          )
        end

        def single!(finder_class, entity_type, params, options, *)
          apply_id(params)

          if entity_type.nil?
            finder_class.new(filter: options['finder.params'], page: params[:page],
                             per_page: params[:per_page]).results.first
          else
            finder_class.new(entity_type: entity_type,
                             filter: options['finder.params']).results.first
          end
        end

        def apply_id(params)
          return if params[:id].blank? || options['finder.params'][:id].present?

          options['finder.params'][:id] = params[:id]
        end

        def normalize_params!(options, params)
          options['finder.params'] ||= {}

          options['finder.keys']&.each do |key|
            value = params.delete(key)

            options['finder.params'][key] = value if value.present?
          end

          options['finder.params'].merge!(options['finder.defaults'] || {})
        end
      end
    end
  end
end
