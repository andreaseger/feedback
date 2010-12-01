Feedback::Application.routes.draw do
  #devise_for :users

  resources :sessions
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

  resources :sheets
  root :to => "sheets#index"
end

