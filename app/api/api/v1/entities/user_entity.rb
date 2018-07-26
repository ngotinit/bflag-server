module API
  module V1
    module Entities
      class UserEntity < Grape::Entity
        expose :email
        expose :username
        expose :first_name, if: lambda { |instance, options| options[:format] == 'full' }
        expose :last_name, if: lambda { |instance, options| options[:format] == 'full' }
        expose :profile_image
      end
    end
  end
end
