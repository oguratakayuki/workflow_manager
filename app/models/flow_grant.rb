class FlowGrant < ApplicationRecord
  extend Enumerize
  enumerize :role, in: [:system, :manager, :president], scope: true
  has_many :request_grants
end
