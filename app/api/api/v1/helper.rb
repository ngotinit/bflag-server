module API
  module V1
    module Helper
      def authenticate_token
        if headers['Authentication-Token'].nil?
          error!({ "error_message": "Token not found" }, 404)
        end
        error!("Token invalid", 401) unless current_user
      end

      def current_user
        @current_user ||= User.get_user_from_token(headers['Authentication-Token'])
      end
    end
  end
end
