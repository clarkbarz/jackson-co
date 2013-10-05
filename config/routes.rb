JacksonCo::Application.routes.draw do
  match 'products/shirts', to: 'products#shirts', via: 'get'
  resources :customers
  resources :products do
    resources :details, only: [:new, :create, :destroy]
    resources :colors, only: [:new, :create, :destroy]
  end
  resources :details, only: [:new, :create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'static_pages#home'
  match '/signup', to: 'customers#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'
end
