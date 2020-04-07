# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories, except: [:destroy]
  devise_for :owners
  resources :owners
  get 'edit_account', to: 'owners#edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'houses#index'
  resources :houses
  get 'myhouses', to: 'houses#index_owner'

  resources :conversations do
    resources :messages
  end
end
