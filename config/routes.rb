Feedback::Application.routes.draw do
  devise_for :users

  resources :sheets
  root :to => "sheets#index"
end

