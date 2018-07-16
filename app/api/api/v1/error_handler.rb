module API
  module V1
    module ErrorHandler
      extend ActiveSupport::Concern
      included do
        rescue_from ActiveRecord::RecordNotFound do |e|
          error!(e, 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error!(e, 422)
        end

        rescue_from :all do |e|
          error!(e, 500)
        end
      end
    end
  end
end
