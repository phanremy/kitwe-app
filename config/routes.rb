Rails.application.routes.draw do
  devise_for :users

  root 'profiles#index'
  resource :modal_shared_links, only: :create
  resource :shared_links, only: :create
  resource :downloads, only: :create

  draw :profile

  scope "(:profile_id)" do
    resources :couples, controllers: 'couples', except: %i[index show]

    draw :family
    # resources :events
    # resources :friendships
  end

  # resources :posts
  get '/open-modal', to: 'pages#open_modal', as: 'open_modal'
end
