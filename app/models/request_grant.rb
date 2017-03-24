class RequestGrant < ApplicationRecord
  extend Enumerize
  belongs_to :request
  belongs_to :flow_grant
  belongs_to :authenticatable_user, class_name: 'User'
  belongs_to :authenticated_user, class_name: 'User'
  enumerize :status, in: [:not_judged, :reviewing, :rejected, :granted], scope: true
  scope :reviewable, ->(user) { where(authenticatable_user: user).or(where(authenticatable_role: user.role)).with_status('reviewing') }
  has_associated_audits
  audited associated_with: :request

  enumerize :authenticatable_role, in: [:operator, :manager, :president, :admin, :system], scope: true
  enumerize :authenticatable_type, in: [:auth_by_user, :auth_by_role], scope: true
end
