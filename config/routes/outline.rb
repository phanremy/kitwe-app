namespace :outlines do
  resources :profiles, only: %i[new create edit update] do
    resources :parents, only: %i[new create]
    resources :couples, except: %i[index show destroy]
  end
end
