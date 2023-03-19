Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :pages do
      resources :content_blocks do
        resources :content_images do
          collection do 
            post :update_positions
          end
        end
        collection do
          post :update_positions
        end
        member do
          get :clone
        end
      end
    end
  end
end
