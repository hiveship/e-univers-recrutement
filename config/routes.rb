Recrutement::Application.routes.draw do

  namespace :admin do
    resources :users do
      member do
        post :reset_password
        post :activate
        post :deactivate
        post :set_recruteur
        post :set_admin
        post :set_manager
      end
    end

    resources :sessions do
      member do
        # Ajoue Thomas =====
        resources :candidatures, only: [:new, :create]
        # ==================
        post :activate
        post :deactivate
      end
    end

    # Ajoue Thomas =====
    resources :candidatures, only: [:update, :destroy]
    # ==================

    resources :profils

    resources :evaluations
  end




  namespace :recruteur do

    # Ajoue Thomas =====
    resources :sessions do
      member do
        resources :candidatures, only: [:index]
      end
    end

    resources :candidatures, only: [:show] do
      member do
        patch :set_result
      end
    end

    resources :candidatures, only: [] do
      member do
        resources :evaluations, only: [:index, :new, :create]
      end
    end

    resources :evaluations, except: [:index, :new, :create]
    # ==================

    resources :users
  end


  get '/login' => 'site#login'
  post '/login' => 'site#auth'
  get '/logout' => 'site#logout'

  resources :profils

  resources :user, only: [:update, :edit]

  # Ajoue Thomas =====
  resources :sessions do
    member do
      resources :candidatures, only: [:new, :create]
    end
  end

  resources :candidatures, only: [:destroy]
  # ==================

  root to: 'sessions#index'

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
