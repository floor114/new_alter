class DecisionPolicy < ApplicationPolicy
  delegate :request, to: :record
  delegate :user, to: :request, prefix: true

  def show?
    same_user?(request_user)
  end

  def create?
    # TODO: move to query object
    found_decisions = user.sent_decisions.where(request: request)

    found_decisions.all?(&:ended?) && !same_user?(request_user)
  end

  alias_method :index?, :user_exist?
end
