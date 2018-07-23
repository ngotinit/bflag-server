module API
  module V1
    class RoomAPI < Grape::API
      before do
        authenticate_token!
      end

      desc 'API for getting list of rooms', {
        headers: {
          "Token" => {
            description: "Validates your identity",
            required: true
          }
        }
      }
      get '/rooms' do
        present Room.all, with: Entities::RoomEntity
      end
    end
  end
end
