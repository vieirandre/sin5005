Rails.application.routes.draw do
  get 'scrap_fii/scrapFii'
  root 'home#index'
end
