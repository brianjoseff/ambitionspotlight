Rails.application.routes.draw do
  mount Judge::Engine => '/judge'
  
  resources :albums

  resources :task_submissions do
    member do
      get :reject
      get :accept
      get :pending
    end
  end

  resources :tasks
  resources :documents
  
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations'}
  resources :users
  # match 'user/:name' => 'user#profile'
  
  match '/about', to: "pages#about", via: :get
  match '/leader_dashboard', to: "users#leader_dashboard", via: :get
  
  authenticated :user do
    root to: "pages#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#landing"
    match '/leaders', to: "pages#index", via: :get
  end
  
  # match '/landing', to: 'pages#landing', via: :get
  resources :users, :only => [:show, :edit, :update]
  resources :followships, only: [:create, :destroy]
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  
  # root to: "pages#index"

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
