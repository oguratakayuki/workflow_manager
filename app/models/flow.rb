class Flow < ApplicationRecord
  has_many :flow_flow_grants
  has_many :flow_grants, through: :flow_flow_grants
  def copy_need_grants
    flow_grants.map{|flow_grant| flow_grant.request_grants.build(order: flow_grant.order, role: flow_grant.role, status: :not_judged) }
  end
end
