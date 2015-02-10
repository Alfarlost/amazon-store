Rails.application.routes.draw do
  get 'addresses/create_billing_address'
  post 'addresses/create_billing_address'

  get 'addresses/create_shipping_address'
  post 'addresses/create_shipping_address'

resources :books, only: [:index, :show]
resource :cart, only: [:show]
resources :orderitems, only: [:create, :update, :destroy]
resources :categories, only: [:index, :show]
resources :orders, only: [:index, :show]
resources :categories, only: [:index, :show]
resources :addresses, only: [:update]
resources :credit_cards, only: [:create, :update]

  devise_for :admins
  devise_for :customers
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :customers

   root :to => 'books#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
