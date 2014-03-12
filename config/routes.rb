Recrutement::Application.routes.draw do

  get '/login' => 'site#login'
  post '/login' => 'site#auth'
  get '/logout' => 'site#logout'
  get 'candidatures/:id/delete' => 'candidatures#destroy'

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
        resources :candidatures, only: [:new, :create]
        post :activate
        post :deactivate
      end
    end

    resources :candidatures, only: [:update, :destroy]
    resources :profils
    resources :evaluations
  end

  namespace :recruteur do
    resources :sessions, except: [:destroy, :new, :create] do
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

    resources :user

  end

  resources :candidatures, only: [:destroy, :show]

  resources :sessions, only: [:index, :show] do
    member do
      resources :candidatures, only: [:new, :create]
    end
  end

  resources :candidatures, only: [:destroy,:show]

  root to: 'sessions#index'

end