# frozen_string_literal: true

class AlertsHandler < ApplicationService
  def initialize(operation)
    @operation = operation
  end

  def call
    setup_alerts!
    setup_status!
  end

  private

  attr_reader :operation

  def setup_alerts!
    operation['alerts'] = { message_type => message }.with_indifferent_access
  end

  def setup_status!
    operation['status'] = operation_errors.blank? ? 200 : 422
  end

  def operation_errors
    @operation_errors ||= pundit_error || contract_errors || operation['error_message']
  end

  def contract_errors
    operation['contract.default']&.errors&.full_messages
  end

  def pundit_error
    I18n.t('errors.messages.action_not_allowed') if operation['result.policy.default']&.failure?
  end

  def message
    operation_errors.presence || operation['success_message']
  end

  def message_type
    operation_errors.blank? ? 'notice' : 'alert'
  end
end
