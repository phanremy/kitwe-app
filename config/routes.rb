Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'profiles#index'
  resource :modal_shared_links, only: :create
  resource :shared_links, only: :create
  resource :downloads, only: :create

  resources :profiles do
    scope module: 'profiles' do
      collection do
        resources :filters, only: :new,
                            as: :profile_filters

        resources :exports, only: :create,
                            as: :profile_exports

        resources :imports, only: %w[new create],
                            as: :profile_imports
      end
    end
  end
  scope "(:profile_id)" do
    resources :couples, controllers: 'couples', except: :show
    resources :families, only: %w[index] do
      collection do
        get '/tree', to: 'families#tree', as: 'tree'
      end
    end
    get '/birthdays', to: 'profiles#birth_dates', as: 'profile_birth_dates'
    get '/children', to: 'profiles#children', as: 'profile_children'
    # resources :events
    # resources :friendships
  end

  resources :posts
  get '/open-modal', to: 'pages#open_modal', as: 'open_modal'
end
