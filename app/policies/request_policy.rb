class RequestPolicy < ApplicationPolicy
  delegate :unconfirmed?, :active?, to: :record

  def update?
    unconfirmed? && same_user?
  end

  alias_method :edit?, :update?
  alias_method :index?, :allowed
  alias_method :show?, :allowed
  alias_method :create?, :allowed
end
