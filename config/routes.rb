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

  devise_scope :candidate do
    post "/auth/github" => "omniauth_callbacks#passthru", as: :candidate_github_omniauth_authorize
    post "/auth/google_oauth2" => "omniauth_callbacks#passthru", as: :candidate_google_oauth2_omniauth_authorize
  end

  devise_scope :recruiter do
    post "/auth/github" => "omniauth_callbacks#passthru", as: :recruiter_github_omniauth_authorize
    post "/auth/google_oauth2" => "omniauth_callbacks#passthru", as: :recruiter_google_oauth2_omniauth_authorize
  end

  get "/auth/github/callback" => "omniauth_callbacks#github", as: :github_omniauth_callback
  get "/auth/google_oauth2/callback" => "omniauth_callbacks#google_oauth2", as: :google_oauth2_omniauth_callback

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
