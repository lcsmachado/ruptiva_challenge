class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def update?
    user.admin? || scope.id == user.id
  end

  def destroy?
    user.admin? || scope.id == user.id
  end
  
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
