class ApprovalFlow < ApplicationRecord
  include UserRoleEnumerations
  belongs_to :job, inverse_of: :approval_flows
  acts_as_list scope: :job
  has_many :request_grants

  def users_by_role
    User.where(role: role)
  end
end
