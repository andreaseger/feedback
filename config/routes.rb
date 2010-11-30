Feedback::Application.routes.draw do
  devise_for :users

  get 'login' => 'ldap#login', :as => 'login'   # login form
  post 'login' => 'ldap#create'

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

