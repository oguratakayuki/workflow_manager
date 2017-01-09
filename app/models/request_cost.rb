class RequestCost < ApplicationRecord
  extend Enumerize
  belongs_to :request
  enumerize :cost_price_type, in: %i(one_time monthly each_year), scope: true
end
