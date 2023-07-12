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
    scope module: 'profiles', as: 'profile' do
      collection do
        resources :filters, only: :new
        resources :exports, only: :create
        resources :imports, only: %w[new create]
      end
    end
  end
  scope "(:profile_id)" do
    # TODO: put in resource profile
    resources :couples, controllers: 'couples', except: %i[show]

    resources :families, only: %w[index] do
      scope module: 'families' do
        collection do
          resource :outline, only: %w[create]
        end
      end
      # TODO: create TreesController
      collection do
        get '/tree', to: 'families#tree', as: 'tree'
      end
    end
    get '/birthdays', to: 'profiles#birth_dates', as: 'profile_birth_dates'

    # resources :events
    # resources :friendships
  end

  resources :posts
  get '/open-modal', to: 'pages#open_modal', as: 'open_modal'
end
