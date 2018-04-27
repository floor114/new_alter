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
    (same_user? && confirmed?) || user_with_privileges?
  end

  alias_method :index?, :allowed
  alias_method :show?, :allowed
  alias_method :create?, :allowed
end
