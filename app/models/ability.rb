# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(owner)
    if owner.present?
      can :manage, House, owner_id: owner.id
      can :show, House.without_deleted
      can :manage, Owner, id: owner.id
      can :read, Category
      if owner.admin?
        can :manage, House
        can :manage, Category
      end
    else
      can :show, House.without_deleted
      can :create, Owner
      can :index, House
    end
  end
end
