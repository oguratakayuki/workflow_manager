class FlowGrant < ApplicationRecord
  extend Enumerize
  enumerize :role, in: [:system, :manager, :president], scope: true
  has_many :request_grants
  belongs_to :flow_flow_grant
end
