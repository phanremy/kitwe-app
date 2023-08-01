namespace :outlines do
  resources :profiles, only: %i[new create edit update] do
    resources :parents, only: %i[new create]
    resources :couples, only: %i[new create destroy]
  end
end
