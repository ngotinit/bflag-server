Rails.application.routes.draw do
  # API Endpoints
  mount API::Base => '/'

  # CMS
  namespace :admin do
    root to: 'sessions#new'
    get '/login', to: 'sessions#new'
    post '/', to: 'sessions#create'
    delete '/', to: 'sessions#destroy'

    resources :users
  end
end
