Rails.application.routes.draw do
  # API Endpoints
  mount API::Base => '/'

  # Action Cable
  mount ActionCable.server => '/cable'

  # API Documentation
  mount GrapeSwaggerRails::Engine => '/swagger'

  # CMS
  namespace :admin do
    root to: 'sessions#new'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/', to: 'sessions#destroy'

    resources :users, only: %i[index show destroy]

    devise_for :users, skip: :sessions, controllers: {
      registrations: 'admin/users/registrations'
    }
  end
end
