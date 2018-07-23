Rails.application.routes.draw do
  # CMS
  namespace :admin do
    root to: 'sessions#new'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/', to: 'sessions#destroy'

    resources :users # only: %i[index show destroy]
  end

  # API Endpoints
  mount API::Base => '/'

  # API Documentation
  mount GrapeSwaggerRails::Engine => '/swagger'

  # Action Cable
  mount ActionCable.server => '/cable'
end
