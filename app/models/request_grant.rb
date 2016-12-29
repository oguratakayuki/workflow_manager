class RequestGrant < ApplicationRecord
  include UserRoleEnumerations
  extend Enumerize
  belongs_to :request
  belongs_to :flow_grant
  belongs_to :user
  enumerize :status, in: [:not_judged, :reviewing, :rejected, :granted], scope: true
end
