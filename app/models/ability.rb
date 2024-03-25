class Ability
  include CanCan::Ability

  def initialize(user)

    if user.role == "manager"
      can :manage, Project, id: user.projects.pluck(:id)
      can :manage, Bug, project_id: user.projects.pluck(:id)
    elsif user.role == "quality_assurance"
      can :create, Bug
      can [:read, :update, :destroy], Bug, project_id: user.projects.pluck(:id)
      can :read, Project, id: user.projects.pluck(:id)
    elsif user.role == "developer"
      can :read, Bug, project_id: user.projects.pluck(:id)
      cannot [:create, :destroy], Bug
      can :read, Project, id: user.projects.pluck(:id)
    end
  end
end
