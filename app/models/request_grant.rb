class RequestGrant < ApplicationRecord
  extend Enumerize
  belongs_to :flow_grant
  belongs_to :user
  enumerize :status, in: [:not_judged, :reviewing, :rejected, :granted], scope: true
  enumerize :role, in: [:system, :manager, :president], scope: true

end
