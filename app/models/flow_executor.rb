class FlowExecutor < ApplicationRecord
  include UserRoleEnumerations
  belongs_to :flow
  belongs_to :user
  scope :by_user, ->(user) { where(user: user).or(where(role: user.role)) }
end
