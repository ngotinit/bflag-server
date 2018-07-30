class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  mount_uploader :profile_image, ProfileImageUploader

  validates :username,
            presence: true,
            length: { in: 6..20 },
            uniqueness: { case_sensitive: false }
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true
  validates :password,
            confirmation: true,
            length: { minimum: 6 },
            if: :require_password?

  attr_accessor :reset_code

  before_save :downcase_field, :check_password

  def self.get_user_from_token(token)
    User.find_by(auth_token: token)
  end

  def self.search(term)
    if term
      where('username LIKE :search OR
            email LIKE :search OR
            first_name LIKE :search OR
            last_name LIKE :search',
            search: "%#{term}%")
    else
      all
    end
  end

  def generate_token
    self.auth_token = nil
    loop do
      self.auth_token = new_token
      break unless User.exists?(auth_token: auth_token)
    end
    save!
  end

  def destroy_token
    update(auth_token: nil)
  end

  def valid_password?(password)
    self.password == digest_token(password)
  end

  def reset_expired?
    reset_sent_at < 6.hours.ago
  end

  def valid_reset_code?(code)
    reset_digest == digest_token(code)
  end

  def create_reset_code
    reset_code = generate_code
    update_columns(reset_digest: digest_token(reset_code),
                   reset_sent_at: Time.zone.now)
  end

  def send_password_reset_mail
    UserMailer.reset_password(self).deliver_later
  end

  private

  def downcase_field
    username.downcase!
    email.downcase!
  end

  def require_password?
    new_record? || !password.empty? || !password_confirmation.empty?
  end

  def check_password
    return unless new_record? || password_changed?
    self.password = digest_token(password)
  end

  def digest_token(token)
    Digest::SHA256.hexdigest(token)
  end

  def new_token
    SecureRandom.hex(16)
  end
end
