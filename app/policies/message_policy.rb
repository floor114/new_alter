class MessagePolicy < ::ApplicationPolicy
  delegate :receiver, :receiver_type, to: :record

  def request_destroy?
    act_as_assigned_user? && receiver_request?
  end

  def request_create?
    user_exist? && receiver_request? && receiver.confirmed?
  end

  def receiver_request?
    receiver_type == ::Request.name
  end

  alias_method :request_index?, :allowed
end
