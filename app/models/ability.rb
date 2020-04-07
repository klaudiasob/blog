# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(owner)
    if owner.present?
      alias_action :create, :read, :update, :destroy, :index_owner, to: :crud
      can :crud, House, owner_id: owner.id
      can :read, House
      can :crud, Owner, id: owner.id
    else
      can :read, House
      can :create, Owner
    end
  end
end
