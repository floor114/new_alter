require 'support/helpers/session_helpers'
require 'support/helpers/trailblazer_helpers'

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
  config.include Features::TrailblazerHelpers
end
