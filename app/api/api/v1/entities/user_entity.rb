module API
  module V1
    module Entities
      class UserEntity < Grape::Entity
        expose :email
        expose :username
        expose :first_name
        expose :last_name
        expose :profile_image
      end
    end
  end
end
