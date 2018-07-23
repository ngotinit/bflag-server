module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user(request.headers['Token'])
    end

    private

    def find_verified_user(token)
      if verified_user = User.get_user_from_token(token)
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
