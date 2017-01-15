class Shop < ApplicationRecord
  has_many :shop_users
  has_many :users, through: :shop_users
end
