class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :create, Inquiry
      can %i(read restart), Inquiry, user_id: user.id
    end
  end
end