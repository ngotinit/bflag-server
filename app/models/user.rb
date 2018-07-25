class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  validates :username,
            length: { minimum: 6 },
            uniqueness: { case_sensitive: false }

  has_one :avatar, inverse_of: :user, dependent: :destroy
  has_many :messages, dependent: :destroy

  accepts_nested_attributes_for :avatar, allow_destroy: true

  validates :password, confirmation: true

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
