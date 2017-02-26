class RequestGrant < ApplicationRecord
  include UserRoleEnumerations
  extend Enumerize
  belongs_to :request
  belongs_to :flow_grant
  belongs_to :user
  enumerize :status, in: [:not_judged, :reviewing, :rejected, :granted], scope: true
  scope :user_reviewable, ->(user) { with_role(user.role).with_status('reviewing') }
  has_associated_audits
  audited associated_with: :request
end
