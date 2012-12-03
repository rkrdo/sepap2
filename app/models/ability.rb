class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new       
    if user.admin?      
      can :manage, :all
    elsif user.teacher?
      can :read, :all
      can :manage, Group
      can :manage, Assignment
      can :manage, Subject
    end
  end 
end  