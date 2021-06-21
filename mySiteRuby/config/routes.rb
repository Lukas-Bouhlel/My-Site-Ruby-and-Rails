Rails.application.routes.draw do

  get 'articles/index', to: 'articles#index', as: :index_articles
  get 'articles/edit', to: 'articles#edit', as: :edit_articles
  
  root to: 'welcome#index', as: :index
  get '/home', to: 'home#index', as: :home

  get '/profil', to: 'users#edit', as: :profil
  patch '/profil', to: 'users#update'

  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :destroy_session

  resources :articles, only: [:new, :create, :edit, :index]
  resources :passwords, only: [:new, :create, :edit, :update]
  resources :users, only: [:new, :create, :edit] do
    member do
      get 'confirm'
    end
  end
  
  scope 'superadmin', module: 'admin', as: 'admin' do
    resources :users, except: [:show]
  end

end