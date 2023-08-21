# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'dashboards#show', as: :authenticated_root
  end

  root 'pages#home'

  get '/home', to: 'pages#home'
  get '/about', to: 'pages#home'
  get '/cotizacion', to: 'pages#home'

  resource :dashboard, only: :show
end
