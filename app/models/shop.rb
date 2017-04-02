class Shop < ApplicationRecord
  belongs_to :brand
  has_many :shop_users
  has_many :users, through: :shop_users
end
