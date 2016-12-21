class Request < ApplicationRecord
  belongs_to :job
  belongs_to :user
  has_many :request_grants
  def status
    if role = next_request_grant.try(:role)
      "#{role.text}の承認待ち"
    else
    end
  end
  def next_request_grant
    request_grants.with_status(:not_judged).order(:order).first
  end
end
