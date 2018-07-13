module API
  class Base < Grape::API
    prefix :api
    format :json

    mount API::V1::Base
  end
end
