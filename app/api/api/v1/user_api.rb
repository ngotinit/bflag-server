module API::V1
  class UserAPI < Grape::API
    version :v1

    resources :users do
      get do
        demo = { hello: "world" }
        present demo
      end
    end
  end
end
