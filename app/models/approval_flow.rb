class ApprovalFlow < ApplicationRecord
  extend Enumerize
  belongs_to :flow, inverse_of: :approval_flows
  acts_as_list scope: :flow
  has_many :request_grants
  belongs_to :authenticatable_user, class_name: 'User'
  enumerize :authenticatable_role, in: [:operator, :manager, :president, :admin, :system], scope: true

  def users_by_role
    User.where(role: role)
  end
end
