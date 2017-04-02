class User < ApplicationRecord
  include UserRoleEnumerations
  has_many :shop_users
  has_many :shops, through: :shop_users
  has_many :brands, through: :shops
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:login_id]
  validates_uniqueness_of :login_id
  validates_presence_of :login_id

  # user_idを仕様してログインするようオーバーライド
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      # 認証の条件式を変更する
      where(conditions).where(["login_id = :value", {:value => login_id}]).first
    else
      where(conditions).first
    end 
  end 

  # 登録時にemailを不要とする
  def email_required?
    false
  end 

  def email_changed?
    false
  end 
end
