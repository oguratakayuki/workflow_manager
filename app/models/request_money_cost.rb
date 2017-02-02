class RequestMoneyCost < ApplicationRecord
  belongs_to :request_initial_cost
  belongs_to :request_monthly_cost
  belongs_to :request_annual_cost
end

