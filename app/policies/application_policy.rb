class ApplicationPolicy
  attr_reader :user, :record

  delegate :user, to: :record, allow_nil: true, prefix: true

  def initialize(user, record = nil)
    @user = user
    @record = record
  end

  def user_with_privileges?
    user_exist? && (user.administrator? || user.moderator?)
  end

  private

  def act_as_assigned_user?(other_user = record_user)
    user == other_user
  end

  def allowed
    true
  end

  def not_allowed
    false
  end

  def user_exist?
    user.present?
  end

  alias_method :index?, :not_allowed

  public :index?
end
