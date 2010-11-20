class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :admin
      can :manage, :all
    elsif user.role? :student
      can :read, :all
      if user.role? :intern
        can :create, Sheet do
          user.sheet == nil
        end
        can :update, Sheet do |sheet|
          sheet.try(:user) == user
        end
      end
    end
  end
end

