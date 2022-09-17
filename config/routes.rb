# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'products#index'
  resources :products do
    resources :order_items, only: %i[create update destroy]
    collection do
      post 'fetch_products', as: :fetch
    end
  end
  resources :orders do
    collection do
      post 'cancel_order', as: :cancel
    end
  end
  resources :users, only: %i[] do
    collection do
      get :order_items
    end
  end
end
