class RequestInitialMoneyCost < RequestMoneyCost
  belongs_to :request
  has_associated_audits
end
