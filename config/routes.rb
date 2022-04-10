# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               registrations: 'sign_up',
               sign_out: 'logout'
             },
             controllers: {
               confirmations: 'confirmations',
               sessions: 'sessions',
               registrations: 'registrations',
               passwords: 'passwords'
             }
  resources :articles, only: %i[index show], param: :slug
  resources :landing_pages, only: %i[show], param: :slug
  resources :organizations, only: %i[index show], param: :slug
  resources :press_releases, only: %i[index show], param: :slug
  resources :splash_sections, only: %i[index]
  resources :writers, only: %i[show], param: :slug

  get '/timeline', to: 'tweets#timeline'

  namespace :admin do
    resources :articles
    resources :landing_pages, only: %i[show update], param: :slug
    resources :organizations
    resources :press_releases
    resources :splash_sections
    resources :writers
  end
end
