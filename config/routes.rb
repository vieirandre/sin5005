Rails.application.routes.draw do
  root 'home#index'
  get 'noticias/fii/:id', to: "noticias#fii"
end
