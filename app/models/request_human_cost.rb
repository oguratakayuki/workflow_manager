class RequestHumanCost < ApplicationRecord
  belongs_to :request_initial_human_cost
  belongs_to :request_monthly_human_cost
  belongs_to :request_annual_human_cost
end
