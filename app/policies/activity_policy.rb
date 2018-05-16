class ActivityPolicy < ::ApplicationPolicy
  alias_method :request_index?, :user_exist?
end
