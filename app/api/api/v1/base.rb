module API
  module V1
    class Base < Grape::API
      version :v1
      include API::V1::ErrorHandler

      helpers do
        include API::V1::Helper
      end

      mount API::V1::UserAPI
      mount API::V1::RoomAPI
      mount API::V1::ResetPasswordAPI
    end
  end
end
