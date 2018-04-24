# frozen_string_literal: true

module Assets
  class Base < ApplicationService
    def initialize(type, options)
      @type = type
      @controller = options[:controller]
      @action = options[:action]
    end

    def call
      asset_available? ? path : ''
    end

    private

    attr_reader :type, :controller, :action

    def path
      raise NotImplementedError
    end

    def asset_available?
      return ::Rails.application.precompiled_assets.include?(path) if assets_compile?

      ::Rails.application.assets_manifest.assets[path].present?
    end

    def assets_compile?
      ::Rails.configuration.assets.compile
    end
  end
end
