class ApprovalFlow < ApplicationRecord
  extend Enumerize
  belongs_to :flow, inverse_of: :approval_flows
  acts_as_list scope: :flow
  has_many :request_grants
  belongs_to :authenticatable_user, class_name: 'User'
  enumerize :authenticatable_role, in: [:operator, :manager, :president, :admin, :system], scope: true
  enumerize :authenticatable_type, in: [:auth_by_user, :auth_by_role], scope: true
  validates :authenticatable_role, presence: :true, if: Proc.new {|a| a.authenticatable_type == 'auth_by_role' }
  validates :authenticatable_user_id, presence: :true, if: Proc.new {|a|  a.authenticatable_type == 'auth_by_user' }

  def users_by_role
    User.where(role: role)
  end
end
