JacksonCo::Application.routes.draw do
  resources :customers
  resources :products
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'static_pages#home'
  match '/signup', to: 'customers#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'

  namespace :admin do
  	get '', to: 'dashboard#index', as: '/'
  end
end
