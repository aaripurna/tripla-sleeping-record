Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :clock_ins, only: [ :create, :index ]
        resources :clock_in_summaries, only: [ :index ] do
          collection do
            get :followings
          end
        end
      end
      resources :follows, only: [ :create ] do
        collection do
          delete :unfollow
        end
      end
    end
  end
end
