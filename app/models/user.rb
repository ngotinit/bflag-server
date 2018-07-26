class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  mount_uploader :profile_image, ProfileImageUploader

  validates :username,
            length: { minimum: 6 },
            uniqueness: { case_sensitive: false }
  validates :password, confirmation: true

  has_many :messages, dependent: :destroy

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

  private

  def new_token
    SecureRandom.hex(16)
  end
end
