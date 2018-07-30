Rails.application.routes.draw do
  # CMS
  concern :with_datatable do
    post 'datatable', on: :collection
  end

  namespace :admin do
    root to: 'sessions#new'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/', to: 'sessions#destroy'

    resources :users, concerns: [:with_datatable]
  end

  # API Endpoints
  mount API::Base => '/'

  # API Documentation
  mount GrapeSwaggerRails::Engine => '/swagger'

  # Action Cable
  mount ActionCable.server => '/cable'
  get 'admin/users/room_chat'
end
