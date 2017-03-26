class User < ApplicationRecord
  include UserRoleEnumerations
  has_many :shop_users
  has_many :shops, through: :shop_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
