Rails.application.routes.draw do
  root 'top#index'
  get 'about', to: 'top#about', as: :about
  get 'bad_request', to: 'top#bad_request'
  get 'forbidden', to: 'top#forbidden'
  get 'internal_server_error', to: 'top#internal_server_error'

  resources :members do
    get 'search', on: :collection
    resources :entries, only: [:index]
  end

  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:show, :edit, :update]

  resources :articles
  resources :entries
end
