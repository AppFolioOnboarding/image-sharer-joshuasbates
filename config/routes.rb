Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'application/home'

  resources :images do
    resources :image_shares, only: %i[new create]
  end

  root 'images#index'
end
