class Request < ApplicationRecord
  belongs_to :job
  belongs_to :user
  has_many :request_grants
end
