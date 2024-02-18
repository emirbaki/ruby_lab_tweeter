Rails.application.routes.draw do
  resources :users do
    get 'profile', to: 'users#show', as: 'user_profile' # Define the user profile route
  end

  get 'session/new'
  get 'session/create'
  get 'session/destroy'
  # resources :tweets
  # resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "logout" => "session#destroy", :as => "logout"
  get "login" => "session#new", :as => "login"
  post "login" => "session#create"
  get "signup" => "users#new", :as => "signup"
  get 'tweets/hashtag/:hashtag', to: 'tweets#tweets_by_hashtag', as: 'tweets_by_hashtag'
  # resources :users
  resources :session
  resources :tweets
  resources :hashtags
  resources :mentions

  # resources :users do
  #   resources :tweets
  # end
  root :to => "tweets#index"
  # Defines the root path route ("/")
  # root "posts#index"
end
