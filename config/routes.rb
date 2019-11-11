Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  resources :usuarios
  root 'home#index'
  get 'fundos', to: 'fundos#index'
  get 'fundos/:ticker', to: 'fundos#recupera'
  get 'integra/:ticker', to: 'fundos#integra'
  post 'fundos/popula', to: 'fundos#popula'
  resources :dados_fundos
  get 'noticias/fii/:id', to: "noticias#fii"
  get 'noticias/fii/', to: "noticias#fii"

  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

end