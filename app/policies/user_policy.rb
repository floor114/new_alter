class UserPolicy < ApplicationPolicy
  alias_method :show?, :allowed
end
