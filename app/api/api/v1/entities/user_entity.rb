module API
  module V1
    module Entities
      class UserEntity < Grape::Entity
        expose :email
        expose :username
        expose :full_name do |instance, options|
          "#{instance.first_name} #{instance.last_name}"
        end

        # expose :first_name
        # expose :last_name
      end
    end
  end
end
