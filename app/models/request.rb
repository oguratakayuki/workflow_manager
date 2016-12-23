class Request < ApplicationRecord
  extend Enumerize
  belongs_to :job
  belongs_to :user
  has_many :request_grants
  has_many :evidences
  scope :reviewable_by_role, ->(role) { joins(:request_grants).merge(RequestGrant.with_role(role).with_status('reviewing')) }
  enumerize :status, in: [:reviewing, :rejected, :executable, :executed], scope: true
  accepts_nested_attributes_for :evidences

  def next_request_grant
    request_grants.with_status(:not_judged).order(:order).first
  end
  def reviewable?(user)
    reviewable_request_grant
  end
  def reviewable_request_grant
    request_grants.with_role(user.role).with_status('reviewing').first
  end

  def self.executable_request_grant(user)
    where(status: 'executable').joins(job: :executor).merge(JobExecutor.where(user: user).or(JobExecutor.where(role: user.role)))
  end

end
