Rails.application.routes.draw do
  resources :fundos
  root 'home#index'
  get 'noticias/fii/:id', to: "noticias#fii"
  get 'noticias/fii/', to: "noticias#fii"
end
