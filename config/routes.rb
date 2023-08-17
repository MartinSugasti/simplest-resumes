# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'
  get '/about', to: 'pages#home'
  get '/cotizacion', to: 'pages#home'
end
