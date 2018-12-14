Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create]
    end

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  get '/auth/github', as: 'github_auth'
  get '/auth/github/callback', to: 'users#update'
  get '/auth/failure', to: 'users#update'

  get '/invite', to: 'invite#new'
  post '/invitation', to: 'invite#create'

  resources :users, only: [:new, :create, :update, :edit] do
    get '/friendships', to: "friendships#create"
    post '/friendships', to: "friendships#create"
    get '/activate', to: 'users#confirm_email'
  end

  resources :tutorials, only: [:show, :index] do
    resources :videos, only: [:show, :index]
  end

  resources :user_videos, only: [:create]
end
