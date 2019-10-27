Rails.application.routes.draw do
  root 'home#index'
  get 'fundos', to: 'fundos#index'
  get 'fundos/:ticker', to: 'fundos#recupera'
  post 'fundos/popula', to: 'fundos#popula'
  resources :dados_fundos
  get 'scrap_fii/scrapFii'
  get 'noticias/fii/:id', to: "noticias#fii"
  get 'noticias/fii/', to: "noticias#fii"
end