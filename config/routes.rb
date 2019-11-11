Rails.application.routes.draw do
  resources :usuarios
  root 'home#index'
  get 'fundos', to: 'fundos#index'
  get 'fundos/:ticker', to: 'fundos#recupera'
  get 'integra/:ticker', to: 'fundos#integra'
  post 'fundos/popula', to: 'fundos#popula'
  resources :dados_fundos
  get 'noticias/fii/:id', to: "noticias#fii"
  get 'noticias/fii/', to: "noticias#fii"
end