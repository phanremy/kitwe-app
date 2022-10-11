Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'profiles#birthdays'
  resources :profiles
  scope "(:profile_id)" do
    resources :couples, controllers: 'couples'
    resources :families, only: %w[index create]
    get '/birthdays', to: 'profiles#birthdays', as: 'profile_birthdays'
    get '/children', to: 'profiles#children', as: 'profile_children'
    # resources :events
    # resources :friendships
  end

  resources :posts
  get '/open-modal', to: 'pages#open_modal', as: 'open_modal'
end
