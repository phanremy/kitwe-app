Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'profiles#index'
  resources :profiles do
    scope module: 'profiles' do
      resource :shared_links, only: :create
      collection do
        resources :filters, only: :new,
                            as: :profile_filters
      end
    end
  end
  scope "(:profile_id)" do
    resources :couples, controllers: 'couples', except: :show
    resources :families, only: %w[index]
    get '/birthdays', to: 'profiles#birthdays', as: 'profile_birthdays'
    get '/children', to: 'profiles#children', as: 'profile_children'
    # resources :events
    # resources :friendships
  end

  resources :posts
  get '/open-modal', to: 'pages#open_modal', as: 'open_modal'
end
