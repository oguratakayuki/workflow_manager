class JobExecutor < ApplicationRecord
  include UserRoleEnumerations
  belongs_to :job
  belongs_to :user
end
