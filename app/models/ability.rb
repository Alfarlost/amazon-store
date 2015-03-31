class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_a?(Admin)
      can :access, :rails_admin
      can :dashboard
      can :manage, Book
      can :manage, Author
      can :manage, Category
      can [:read, :update], Rating
      can :manage, Order
    elsif user.is_a?(Customer)
      can :read, [Book, Category]
      can :manage, Order, customer_id: user.id
      cannot :destroy, Order
      can :manage, Orderitem, Orderitem.where(:order_id => user.orders.ids).order(id: :desc) do |orderitem|
        orderitem.order.customer_id == user.id
      end
      can [:new, :read, :create], Rating
      can :update, Rating, customer_id: user.id
      can [:read, :update], Customer, user.id
      can :manage, Address, customer_id: user.id
    else
      can :manage, Orderitem
      can :apply_discount, Order
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
