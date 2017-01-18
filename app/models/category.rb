class Category < ApplicationRecord
  has_many :requests
  has_many :sub_categories
end
