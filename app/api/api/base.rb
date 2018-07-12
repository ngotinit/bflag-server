module API
  class Base < Grape::API
    format :json
    prefix :api

    mount V1::UserAPI
  end
end
