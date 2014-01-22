ProjetRecrutement::Application.routes.draw do
  resources :users
    get '/login' => 'site#login'
    post '/login' => 'site#auth'
    get '/logout' => 'site#logout'
    get 'activate' => 'users#activate_user'
    get '/deactivate' => 'users#deactivate_user'
    get'/reset_password' => 'users#reset_user_password'
    get'/set_admin' => 'users#set_admin'
    get'/set_recruteur' => 'users#set_recruteur'


  resources :sessions

  resources :profils

  resources :evaluations

  resources :candidatures
  # A modifier pour root to: site#index
  root to: 'site#login'
end
