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

  resources :events, param: :slug do
    get :index
    get :show

    collection do
      get :next
    end
  end

  resources :landing_pages, only: %i[show], param: :slug
  resources :organizations, only: %i[index show], param: :slug
  resources :press_releases, only: %i[index show], param: :slug
  resources :splash_sections, only: %i[index]
  resources :writers, only: %i[show], param: :slug

  resources :users, only: %i[] do
    collection do
      post :set_password
    end
  end

  get '/timeline', to: 'tweets#timeline'

  namespace :admin do
    resources :articles
    resources :events
    resources :landing_pages, only: %i[show update], param: :slug
    resources :organizations
    resources :press_releases
    resources :splash_sections

    resources :users, only: %i[index show create update destroy] do
      collection do
        get :team
      end
    end

    resources :writers

    post 'authorization', to: 'authorizations#authorization'
  end
end
