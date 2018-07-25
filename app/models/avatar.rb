class Avatar < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  attr_accessor :avatar
  belongs_to :user
end
