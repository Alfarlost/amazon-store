class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_a?(Admin)
      can :access, :rails_admin
      can :dashboard
      can :manage, Book
      can :manage, Author
      can :manage, Category
      can :read, Rating
      can :update, Rating
      can :read, Order
      can :update, Order
    elsif user.is_a?(Customer)
      can :read, Book
      can :read, Category
      can :manage, Order, customer_id: customer.id
      cannot :destroy, Order
      can :manage, OrderItem do |order_item|
        order_item.order.user_id==user.id
      end
      can :manage, CrediCard, customer_id: customer.id
      cannot :destroy, CrediCard
      can :new, Rating
      can :read, Rating
      can :update, Rating, customer_id: customer.id
      can :read, Customer, customer.id
      can :update, Customer, customer.id
    else
      can :read, Book
      can :read, Category
      can :read, Rating
    end

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
end
