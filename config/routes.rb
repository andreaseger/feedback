Feedback::Application.routes.draw do
  resources :sheets
  root :to => "sheets#index"
end

