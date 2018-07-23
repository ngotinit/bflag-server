module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      token = request.headers['Token']
      self.current_user = User.get_user_from_token(token)
      reject_unauthorized_connection unless self.current_user
    end
  end
end
