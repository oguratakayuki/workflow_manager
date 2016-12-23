class JobExecutor < ApplicationRecord
  extend Enumerize
  belongs_to :job
  belongs_to :user
  enumerize :role, in: [:system, :manager, :president], scope: true
end
