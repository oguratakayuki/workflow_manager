class FlowExecutor < ApplicationRecord
  include UserRoleEnumerations
  belongs_to :flow
  belongs_to :user
end
