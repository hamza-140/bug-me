class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == "manager"
      can :manage, :all
    elsif user.role == "quality_assurance"
      can :create, Bug
      can [:read, :update, :destroy], Bug, user_id: user.id
      can :read, Project
    elsif user.role == "developer"
      can [:read, :update], Bug, user_id: user.id
      cannot [:create, :destroy], Bug
      can :read, Project, users: { id: user.id }
    end
  end
end
