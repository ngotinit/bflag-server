module API
  module V1
    module Helper
      def authenticate_token!
        error!('401 Token not found', 401) unless request.headers['Token']
        error!('401 Token invalid', 401) unless current_user
      end

      def current_user
        @current_user ||= User.get_user_from_token(headers['Token'])
      end
    end
  end
end
