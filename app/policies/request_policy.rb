class RequestPolicy < ApplicationPolicy
  delegate :unconfirmed?, :confirmed?, to: :record

  def update?
    unconfirmed? && same_user?
  end

  alias_method :edit?, :update?

  def confirm?
    unconfirmed? && user_with_privileges?
  end

  def decline?
    (unconfirmed? || confirmed?) && user_with_privileges?
  end

  def archive?
    confirmed? && (same_user? || user_with_privileges?)
  end

  def create_decision?
    # TODO: move to query object
    found_decisions = user.sent_decisions.where(request: record)

    found_decisions.all?(&:ended?) && !same_user?
  end

  alias_method :index?, :allowed
  alias_method :show?, :allowed
  alias_method :create?, :allowed
end
