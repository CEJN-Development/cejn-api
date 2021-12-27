# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               registrations: 'sign_up'
             },
             controllers: {
               confirmations: 'confirmations',
               sessions: 'sessions',
               registrations: 'registrations',
               passwords: 'passwords'
             }
  resources :bios, only: %i[show], param: :slug
  resources :articles, only: %i[index show], param: :slug
  resources :writers, only: %i[show], param: :slug

  namespace :admin do
    resources :articles
    resources :bios
    resources :writers
  end
end
