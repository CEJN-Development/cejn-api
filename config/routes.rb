# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               registrations: 'sign_up'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations',
               passwords: 'passwords'
             }
  resources :bios, param: :slug
  resources :articles, param: :slug
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
