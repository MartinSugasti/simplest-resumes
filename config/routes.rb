# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }

  authenticated :admin do
    root 'admins/dashboard#show', as: :admins_authenticated_root
  end

  authenticated :user do
    root 'users/dashboard#show', as: :users_authenticated_root
  end

  root 'pages#home'

  get '/home', to: 'pages#home'
  get '/about', to: 'pages#home'
  get '/cotizacion', to: 'pages#home'

  namespace :users do
    get 'dashboard/show'
  end

  namespace :admins do
    get 'dashboard/show'
  end
end
