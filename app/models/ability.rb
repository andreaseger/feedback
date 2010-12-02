class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :admin
      can :manage, :all
    elsif user.role? :student
      can :read, Sheet
      if user.role? :intern
        can :create, Sheet do
          user.sheet == nil
        end
        can :update, Sheet do |sheet|
          sheet.try(:user) == user
        end
      end
    elsif user.role? :extern
      can :read, Sheet
    end
  end
end

