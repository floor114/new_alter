module Features
  module TrailblazerHelpers
    def fetch_operation(specific_params = params, specific_user = user)
      described_class.call(specific_params, 'current_user' => specific_user)
    end
  end
end
