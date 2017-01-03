class Evidence < ApplicationRecord
  mount_uploader :file_name, ImageUploader
end
