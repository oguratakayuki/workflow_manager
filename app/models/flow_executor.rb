class FlowExecutor < ApplicationRecord
  include UserRoleEnumerations
  belongs_to :flow
  belongs_to :user
  scope :by_user, ->(user) do
    where(user: user).or(where(user: nil)).where(role: user.role).or(where(role: nil))
  end
end
