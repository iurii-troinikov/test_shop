# frozen_string_literal: true

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'products#index'
  resources :products, only: %i[index new create show]
end
