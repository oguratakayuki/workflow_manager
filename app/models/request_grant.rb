class RequestGrant < ApplicationRecord
  extend Enumerize
  belongs_to :flow_grant
  belongs_to :user
  enumerize :status, in: [:not_active, :reviewing, :rejected, :granted], scope: true
end
