# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords',
    confirmations: 'admins/confirmations',
    invitations: 'admins/invitations'
  }

  devise_for :candidates, path: 'candidates', controllers: {
    sessions: 'candidates/sessions',
    registrations: 'candidates/registrations',
    passwords: 'candidates/passwords',
    confirmations: 'candidates/confirmations',
    masquerades: "admins/masquerades"
  }

  devise_for :recruiters, path: 'recruiters', controllers: {
    sessions: 'recruiters/sessions',
    registrations: 'recruiters/registrations',
    passwords: 'recruiters/passwords',
    confirmations: 'recruiters/confirmations',
    masquerades: "admins/masquerades"
  }

  authenticated :admin do
    root 'admins/dashboard#show', as: :admins_authenticated_root
  end

  authenticated :candidate do
    root 'candidates/dashboard#show', as: :candidates_authenticated_root
  end

  authenticated :recruiter do
    root 'recruiters/dashboard#show', as: :recruiters_authenticated_root
  end

  root 'pages#home'

  get '/home', to: 'pages#home'
  get '/about', to: 'pages#home'
  get '/cotizacion', to: 'pages#home'

  namespace :admins do
    get 'dashboard/show'
  end

  namespace :candidates do
    get 'dashboard/show'
  end

  namespace :recruiters do
    get 'dashboard/show'
  end
end
