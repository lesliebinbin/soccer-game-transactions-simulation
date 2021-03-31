# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user&.admin_role?
      can :manage, :all
      can :access, :all
    else
      can :manage, Transfer do |transfer|
        transfer.seller.id == user&.id
      end
      can :access, Transfer
      can :manage, Team do |team|
        team.user.id == user&.id
      end
      can :manage, Player do |player|
        player.team.user.id == user&.id
      end
    end
  end
end
