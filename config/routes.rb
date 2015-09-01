Rails.application.routes.draw do

  resources :lists
  resources :actions

  get '/bangbang/:id', to: 'actions#show'

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

  resources :posts do
    collection do
      get 'suggestions'
      # get 'autocomplete_tags'
      # get 'autocomplete_mentions'
      # get 'autocomplete_bangbangs'
    end
  end

  resources :tasks

  resources :activities do
    member do
      get :deactivate
    end
  end

  resources :documents

  resources :spotlights

  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}

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

      get :cancel_edit
    end
    resources :story_elements
  end

  match '/add_story_element', to: "users#add_story_element", via: :post
  match '/add_activity', to: "users#add_activity", via: :post
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
end
