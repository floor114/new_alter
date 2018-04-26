class ApplicationPolicy
  attr_reader :user, :record

  delegate :user, to: :record, allow_nil: true, prefix: true

  def initialize(user, record)
    @user = user
    @record = record
  end

  def allowed
    true
  end

  def not_allowed
    false
  end

  alias_method :index?, :not_allowed

  private

  def same_user?
    record_user == user
  end
end
