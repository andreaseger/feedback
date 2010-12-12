Feedback::Application.routes.draw do
  #devise_for :users

  resources :sessions
  get "users/new" => "users#new", :as => "new_user"
  post "users" => "users#create"
#  match "/auth/ldap/callback" => "sessions#create"
#  match "/auth/ldap/failure" => "sessions#create"

  namespace :admin do
    resources :users do
      collection do
        post :edit_multiple
        put  :update_multiple
      end
    end
  end

  resources :sheets do
    collection do
      get 'search'
    end
  end

  root :to => "sheets#index"
end

