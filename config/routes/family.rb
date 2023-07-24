resources :families, only: %w[index] do
  scope module: 'families', as: 'families' do
    collection do
      resource :outline, only: %w[create]
      resource :tree, only: %w[show]
      resources :profiles, only: %w[new create edit update]
    end
  end
end
