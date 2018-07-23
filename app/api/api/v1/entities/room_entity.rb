module API
  module V1
    module Entities
      class RoomEntity < Grape::Entity
        expose :id
        expose :name
      end
    end
  end
end
