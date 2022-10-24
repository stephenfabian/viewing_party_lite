# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index', as: :landing_page
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get 'register', to: 'users#new'

  resources :users do
    resources :movies do
      resources :viewing_parties, only: %i[new create]
    end

    get 'discover', to: 'movies#search'
  end
end
