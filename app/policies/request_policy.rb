class RequestPolicy < ApplicationPolicy
  delegate :unconfirmed?, :active?, to: :record

  def index?
    true
  end

  def update?
    unconfirmed? && same_user?
  end

  alias_method :edit?, :update?
end
