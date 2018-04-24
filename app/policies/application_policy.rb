class ApplicationPolicy
  attr_reader :user, :record

  delegate :user, to: :record, allow_nil: true, prefix: true

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  alias_method :new?, :create?

  def update?
    false
  end

  alias_method :edit?, :update?

  def destroy?
    false
  end

  private

  def same_user?
    record_user == user
  end
end
