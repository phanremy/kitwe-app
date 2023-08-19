Rails.application.routes.draw do
  devise_for :users

  root 'pages#homepage'
  resource :modal_shared_links, only: :create
  resource :shared_links, only: :create
  resource :downloads, only: :create

  draw :profile

  scope '(:locale)', locale: /fr|en/ do
    resources :profiles, only: %i[index show] do
      resources :couples, controllers: 'couples', except: %i[show destroy]

      resources :families, only: %w[index] do
        scope module: 'families', as: 'families' do
          collection do
            resource :outline, only: %w[create]
            resource :tree, only: %w[show]
          end
        end
      end
      # resources :events
      # resources :friendships
    end

    draw :outline
    resources :users, only: %i[index edit update destroy]
  end

  resources :couples, only: %i[destroy]

  # resources :posts
  get '/open-modal', to: 'pages#open_modal', as: 'open_modal'
end
