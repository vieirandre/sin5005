Rails.application.routes.draw do
  resources :fundos
  root 'home#index'
end
