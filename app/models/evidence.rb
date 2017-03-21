class Evidence < ApplicationRecord
  mount_uploader :file_name, ImageUploader
  belongs_to :request
end
