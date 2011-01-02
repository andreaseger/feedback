Feedback::Application.routes.draw do
  
  scope '(:locale)' do
    resources :sessions
    get "users/new" => "users#new", :as => "new_user"
    post "users" => "users#create"

    namespace :admin do
      resources :users do
        collection do
          post :edit_multiple
          put  :update_multiple
        end
      end
      resources :semesters
    end

    resources :sheets do
      collection do
        get :search
      end
    end

    root :to => "sheets#index"
  end
  match '/:locale' => 'sheets#index'
end

