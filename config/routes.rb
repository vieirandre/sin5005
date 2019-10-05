Rails.application.routes.draw do
  resources :dados_fundos
  get 'scrap_fii/scrapFii'
  root 'home#index'
end
