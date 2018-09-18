Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:new, :create, :destroy]
  
  resources :usernames
  
  resources :questions do 
    resources :answers
  end

    root 'questions#index'

    namespace :api do
      namespace :v1 do
        resources :usernames
        resources :questions do
            resources :answers
        end
        resource :session, only: :create
      end
    end  
end

