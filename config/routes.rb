Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'products#index'
  resources :products do
    resources :order_items, only: %i[create update destroy]
  end
  resources :orders
end
