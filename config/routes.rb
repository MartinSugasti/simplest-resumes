# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  authenticated :admin, ->(admin) { admin.super_admin? } do
    mount Sidekiq::Web, at: 'admins/sidekiq'
  end

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

  devise_scope :admin do
    post 'admins/invitations/resend', to: 'admins/invitations#resend',
                                      as: :resend_admins_invitations,
                                      constraints: { format: :json }
  end

  devise_scope :candidate do
    post "/auth/github" => "omniauth_callbacks#passthru", as: :candidate_github_omniauth_authorize
    post "/auth/google_oauth2" => "omniauth_callbacks#passthru", as: :candidate_google_oauth2_omniauth_authorize
    post "/auth/twitter" => "omniauth_callbacks#passthru", as: :candidate_twitter_omniauth_authorize
  end

  devise_scope :recruiter do
    post "/auth/github" => "omniauth_callbacks#passthru", as: :recruiter_github_omniauth_authorize
    post "/auth/google_oauth2" => "omniauth_callbacks#passthru", as: :recruiter_google_oauth2_omniauth_authorize
    post "/auth/twitter" => "omniauth_callbacks#passthru", as: :recruiter_twitter_omniauth_authorize
  end

  get "/auth/github/callback" => "omniauth_callbacks#github", as: :github_omniauth_callback
  get "/auth/google_oauth2/callback" => "omniauth_callbacks#google_oauth2", as: :google_oauth2_omniauth_callback
  get "/auth/twitter/callback" => "omniauth_callbacks#twitter", as: :twitter_omniauth_callback

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
  post '/contact_form', to: 'contact_form#create'

  namespace :admins do
    get 'dashboard/show'

    resources :admins, only: %i[index]
    resources :candidates, only: %i[index]
    resources :recruiters, only: %i[index]

    resources :invitation_requests, only: %i[index new create] do
      scope constraints: { format: :json } do
        member do
          post :dismiss
          post :ban
        end
      end
    end
  end

  namespace :candidates do
    get 'dashboard/show'

    resources :payments, only: %i[index] do
      post :checkout, on: :collection
    end

    resource :my_resume, only: %i[show update], controller: :my_resume
  end

  namespace :recruiters do
    get 'dashboard/show'
  end

  resources :stripe_webhooks, only: [:create]
end
