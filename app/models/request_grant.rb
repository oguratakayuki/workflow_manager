class RequestGrant < ApplicationRecord
  belongs_to :flow_grant
  enumerize :status, in: [:not_active, :reviewing, :rejected, :granted], scope: true
end
