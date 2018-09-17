Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #resource :session, only: [:new, :create, :destroy]

    root 'questions#index'

    namespace :api do
      namespace :v1 do
        # resources :usernames do
          resources :questions do
            resources :answers
              # resource :session, only: :create
            # end
          end
        # end
      end
    end  
end

