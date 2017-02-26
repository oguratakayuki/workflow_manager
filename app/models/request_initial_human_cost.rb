class RequestInitialHumanCost < RequestHumanCost
  belongs_to :request
  audited associated_with: :request
end
