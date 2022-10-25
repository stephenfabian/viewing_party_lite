# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'welcome#index', as: :landing_page
  get '/login', to: 'users#login_form' #replace with session?
  post '/login', to: 'users#login_user'
  patch '/logout', to: 'users#logout'
  get 'register', to: 'users#new'
  get '/dashboard', to: 'users#show'
  get '/movies/:id', to: 'movies#show'
  resources :users, only: [:new, :create] do
    resources :movies do
      resources :viewing_parties, only: %i[new create]
    end

    get 'discover', to: 'movies#search'
  end
end
