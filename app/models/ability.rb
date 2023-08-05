# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, token = nil)
    token_abilities(token)

    return unless user

    user_abilities(user)
    admin_abilities(user)

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end

  def token_abilities(token)
    return unless token.present?

    can :read, Profile
    can [:index], :family
    can [:show], :tree
    can [:create], :outline
  end

  def admin_abilities(user)
    return if !user.admin? && %w[user2@example.com pocari04@gmail.com].exclude?(user.email)

    can :manage, User
    # can :manage, Post
  end

  def user_abilities(user)
    can :manage, Profile, creator: user
    can :manage, Couple, creator: user
    can %i[new create], :parent
    can %i[new create], :import
    can [:create], :export
    can :manage, :family
    can :create, :modal_shared_link
    can :create, :shared_link
    can :create, :download
    can %i[new create], :filter
  end
end
