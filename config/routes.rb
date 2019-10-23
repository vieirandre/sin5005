Rails.application.routes.draw do
  resources :dados_fundos
  get 'scrap_fii/scrapFii'
  resources :fundos
  root 'home#index'
  get 'noticias/fii/:id', to: "noticias#fii"
  get 'noticias/fii/', to: "noticias#fii"
end
