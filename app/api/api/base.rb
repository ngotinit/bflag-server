module API
  class Base < Grape::API
    prefix :api
    format :json

    mount API::V1::Base

    add_swagger_documentation
  end
end
