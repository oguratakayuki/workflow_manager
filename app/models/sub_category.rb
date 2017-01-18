class SubCategory < ApplicationRecord
  has_many :requests
  belongs_to :category
end
