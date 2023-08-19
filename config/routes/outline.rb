namespace :outlines do
  resources :profiles, only: %i[new create edit update destroy] do
    resources :parents, only: %i[new create]
    resources :couples, only: %i[edit update destroy]
  end
end
