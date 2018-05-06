class UserPolicy < ApplicationPolicy
  alias_method :show?, :user_exist?
  alias_method :index?, :user_exist?
end
