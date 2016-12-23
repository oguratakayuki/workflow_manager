class Job < ApplicationRecord
  belongs_to :flow
  has_many :executors, class_name: 'JobExecutor'
end
