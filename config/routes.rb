Feedback::Application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :users
  end

  resources :sheets
  root :to => "sheets#index"
end

