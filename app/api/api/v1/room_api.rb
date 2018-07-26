module API
  module V1
    class RoomAPI < Grape::API
      before do
        authenticate_token!
      end

      desc 'Get list of rooms', {
        headers: {
          'Token' => {
            description: 'Validates your identity',
            required: true
          }
        }
      }
      get '/rooms' do
        present Room.all, with: Entities::RoomEntity
      end

      desc 'Get history of rooms', {
        headers: {
          'Token' => {
            description: 'Validates your identity',
            required: true
          }
        }
      }
      params do
        requires :offset, type: Integer
      end
      post '/rooms/:id' do
        declared_params = declared(params)
        offset = declared_params[:offset]
        present Message.get_history(offset), with: Entities::MessageEntity
      end
    end
  end
end
