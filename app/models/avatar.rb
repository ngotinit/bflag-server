class Avatar < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
end
