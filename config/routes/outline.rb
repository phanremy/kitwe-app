namespace :outlines do
  resources :profiles, only: %w[new create edit update]
  resources :couples, except: %i[index show destroy]
end
