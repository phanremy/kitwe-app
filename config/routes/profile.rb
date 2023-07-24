resources :profiles do
  scope module: 'profiles', as: 'profile' do
    collection do
      resources :filters, only: :new
      resources :exports, only: :create
      resources :imports, only: %w[new create]
    end
  end
end

get '/birthdays', to: 'profiles#birth_dates', as: 'profile_birth_dates'
