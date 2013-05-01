class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
      can :activate, Problem
    elsif user.teacher?
      can :read, :all
      can :manage, Group
      can :manage, Assignment
      can :manage, Subject
      can :create, User
      can :create, Problem
      cannot :edit, Problem
      cannot :destroy, Problem
      cannot :activate, Problem
    end
  end
end
