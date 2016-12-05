class Flow < ApplicationRecord
  has_many :flow_flow_grants
  has_many :flow_grants, through: :flow_flow_grants
end
