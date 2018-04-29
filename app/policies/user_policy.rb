class UserPolicy < ApplicationPolicy
  alias_method :show?, :user_exist?
end
