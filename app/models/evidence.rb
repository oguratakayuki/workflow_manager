class Evidence < ApplicationRecord
  mount_uploader :file_name, ImageUploader
  belongs_to :request
  belongs_to :upload_user, class_name: 'User'
end
