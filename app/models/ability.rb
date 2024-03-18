class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == "manager"
      can :manage, :all
    elsif user.role == "quality_assurance"
      can :create, Bug
      can [:read, :update, :destroy], Bug
      can :read, Project
    elsif user.role == "developer"
      can [:read], Bug
      cannot [:create, :destroy], Bug
      can :read, Project, users: { id: user.id }
    end
  end
end
