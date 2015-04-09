Rails.application.routes.draw do


  resources :daily_accomplishments

  resources :goals

  mount Judge::Engine => '/judge'
  
  resources :albums
  
  resources :story_elements
  
  resources :task_submissions do
    member do
      get :reject
      get :accept
      get :pending
    end
  end

  resources :tasks
  resources :documents
  resources :spotlights
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}
  resources :activities do
    member do
      get :deactivate
    end
  end
  resources :users do
    member do
      get :admin_edit
      put :admin_update
      get :edit_ambition
      patch :update_ambition
      get :edit_bio
      patch :update_bio
      put :update_rating
      put :update_youtube
      put :update_soundcloud
      # put :add_story_element
      # get :edit_story_element
      # put :update_story_element
      put :add_profile_photo
    end
    resources :story_elements
  end
  
  match '/add_story_element', to: "users#add_story_element", via: :post
  match '/add_activity', to: "users#add_activity", via: :post
  # resources :users do
  #   member do
  #     put :add_activity
  #   end
  # end
  
  
  # match 'user/:name' => 'user#profile'
  match '/icons', to: "pages#icons", via: :get
  match '/about', to: "pages#about", via: :get
  match '/leader_dashboard', to: "users#leader_dashboard", via: :get
  match '/admin', to: "pages#admin", via: :get
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
