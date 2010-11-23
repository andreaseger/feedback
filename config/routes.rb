Feedback::Application.routes.draw do
  devise_for :users

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

