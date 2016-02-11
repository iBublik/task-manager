class TaskPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def show?
    admin_or_owner?
  end

  def update?
    admin_or_owner?
  end

  def destroy?
    admin_or_owner?
  end

  def switch_state?
    !record.final_state? && admin_or_owner?
  end

  def permitted_attributes
    [:name, :description, (:user_id if user.admin?), :attachment,
     :remove_attachment].compact
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.includes(:user)
      else
        scope.where(user: user)
      end
    end
  end

  private

  def admin_or_owner?
    user && (user.admin? || user.id == record.user_id)
  end
end
