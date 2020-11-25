class UserPolicy
  attr_reader :user, :scope

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

  def index?
    user.admin?
  end

  def show?
    user.admin? || scope.id == user.id
  end

  def update?
    user.admin? || scope.id == user.id
  end

  def destroy?
    user.admin? || scope.id == user.id
  end
end
