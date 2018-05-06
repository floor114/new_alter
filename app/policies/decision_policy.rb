class DecisionPolicy < ApplicationPolicy
  delegate :request, :created?, :read?, :ended?, to: :record
  delegate :user, to: :request, prefix: true, allow_nil: true

  def show?
    (read? || created?) && act_as_assigned_user?(request_user)
  end

  alias_method :accept?, :show?
  alias_method :partly_accept?, :accept?
  alias_method :reject?, :accept?

  def create?
    # TODO: move to query object
    found_decisions = user.sent_decisions.where(request: request)

    found_decisions.all?(&:ended?) && !act_as_assigned_user?(request_user)
  end

  alias_method :index?, :user_exist?
end
