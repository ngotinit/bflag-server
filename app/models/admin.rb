class Admin < ApplicationRecord
  before_save :check_password

  def authenticate?(password)
    self.password == digest_password(password)
  end

  def check_password
    return unless new_record? || password_changed?
    self.password = digest_password(password)
  end

  private

  def digest_password(password)
    Digest::SHA256.hexdigest(password)
  end
end
