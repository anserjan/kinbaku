# frozen_string_literal: true

Rails.application.routes.draw do
  # This line mounts Solidus's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"

  mount Spree::Core::Engine, at: '/'
  mount Ckeditor::Engine => '/ckeditor'
  mount SolidusPaypalCommercePlatform::Engine, at: '/solidus_paypal_commerce_platform'

end

Spree::Core::Engine.routes.draw do
  root to: 'home#index'

  devise_for(:spree_user, {
    class_name: 'Spree::User',
    controllers: {
      sessions: 'spree/user_sessions',
      registrations: 'spree/user_registrations',
      passwords: 'spree/user_passwords',
      confirmations: 'spree/user_confirmations'
    },
    skip: [:unlocks, :omniauth_callbacks],
    path_names: { sign_out: 'logout' },
    path_prefix: :user,
    router_name: :spree
  })

  resources :users, only: [:edit, :update]

  devise_scope :spree_user do
    get '/login', to: 'user_sessions#new', as: :login
    post '/login', to: 'user_sessions#create', as: :create_new_session
    match '/logout', to: 'user_sessions#destroy', as: :logout, via: Devise.sign_out_via
    get '/signup', to: 'user_registrations#new', as: :signup
    post '/signup', to: 'user_registrations#create', as: :registration
    get '/password/recover', to: 'user_passwords#new', as: :recover_password
    post '/password/recover', to: 'user_passwords#create', as: :reset_password
    get '/password/change', to: 'user_passwords#edit', as: :edit_password
    put '/password/change', to: 'user_passwords#update', as: :update_password
    get '/confirm', to: 'user_confirmations#show', as: :confirmation if Spree::Auth::Config[:confirmable]
  end

  resource :account, controller: 'users'

  resources :products, only: [:index, :show]

  get '/locale/set', to: 'locale#set'
  post '/locale/set', to: 'locale#set', as: :select_locale

  # non-restful checkout stuff
  get '/checkout/registration', to: 'checkout#registration', as: :checkout_registration
  put '/checkout/registration', to: 'checkout#update_registration', as: :update_checkout_registration
  patch '/checkout/update/:state', to: 'checkout#update', as: :update_checkout
  get '/checkout/:state', to: 'checkout#edit', as: :checkout_state
  get '/checkout', to: 'checkout#edit', as: :checkout

  get '/orders/populate', to: 'orders#populate_redirect'
  get '/orders/:id/token/:token' => 'orders#show', as: :token_order

  resources :orders, except: [:index, :new, :create, :destroy] do
    post :populate, on: :collection
    resources :coupon_codes, only: :create
  end

  get '/cart', to: 'orders#edit', as: :cart
  patch '/cart', to: 'orders#update', as: :update_cart
  put '/cart/empty', to: 'orders#empty', as: :empty_cart

  # route globbing for pretty nested taxon and product paths
  get '/t/*id', to: 'taxons#show', as: :nested_taxons

  get '/unauthorized', to: 'home#unauthorized', as: :unauthorized
  get '/cart_link', to: 'store#cart_link', as: :cart_link

  # register participant for confirmation
  post 'participants/reserve', to: 'participants#reserve', as: :reserve_user
  
  namespace :admin do
    resources :products do
      member do
        put :unlock_course
      end
      resources :participants do
        member do
          put :toggle_confirm
        end
      end
    end
    resources :trainer_cash_lists
    resources :users do
      member do
        get :deposits
        post :deposits
      end
      resources :deposits, only: [:destroy]
    end
    resources :menus do
      collection do
        post :update_positions
      end
    end
  end

end
