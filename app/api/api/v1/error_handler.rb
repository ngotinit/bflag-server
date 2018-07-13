module API
  module V1
    module ErrorHandler
      extend ActiveSupport::Concern
      included do
        rescue_from ActiveRecord::RecordNotFound do |e|
          error!({ error_message: e.message }, 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error!({ error_message: e.message }, 422)
        end

        rescue_from :all do |e|
          error!({ error_message: e.message }, 400)
        end
      end
    end
  end
end
