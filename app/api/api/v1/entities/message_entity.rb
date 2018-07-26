module API
  module V1
    module Entities
      class MessageEntity < Grape::Entity
        format_with(:datetime) do |date|
          date.strftime('%Y-%m-%d %H:%M:%S')
        end

        with_options(format_with: :datetime) do
          expose :created_at
        end
        expose :user, as: :friend, using: UserEntity
        expose :content
      end
    end
  end
end
