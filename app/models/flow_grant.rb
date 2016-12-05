class FlowGrant < ApplicationRecord
  extend Enumerize
  enumerize :grant_type, in: [:system, :manager]
end
