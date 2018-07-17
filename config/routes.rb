Rails.application.routes.draw do
  # API Endpoints
  mount API::Base => '/'

  # API Documentation
  mount GrapeSwaggerRails::Engine => '/swagger'

  # CMS
  namespace :admin do
    root to: 'sessions#new'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/', to: 'sessions#destroy'

    resources :users
  end
end
