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
    permitted?
  end

  def update?
    permitted?
  end

  def destroy?
    permitted?
  end

  private

  def permitted?
    user.admin? || scope.id == user.id
  end
end
