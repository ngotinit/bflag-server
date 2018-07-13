class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  validates :username,
            length: { minimum: 6 },
            uniqueness: { case_sensitive: false }

  def self.get_user_from_token(token)
    user = User.find_by(auth_token: token)
    if user.nil? || !user.valid_token?
      return nil
    else
      return user
    end
  end

  def generate_token
    loop do
      self.auth_token = new_token
      break unless User.exists?(auth_token: auth_token)
    end
    update_columns(auth_token: auth_token, auth_token_expire: Time.zone.now)
  end

  def destroy_token
    update_columns(auth_token: nil, auth_token_expire: nil)
  end

  def valid_token?
    return false if auth_token_expire < 3.days.ago
    true
  end

  private

  def new_token
    SecureRandom.hex(16)
  end
end
