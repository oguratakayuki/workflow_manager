class Job < ApplicationRecord
  has_many :executors, class_name: 'JobExecutor'
  has_many :approval_flows, inverse_of: :job
  accepts_nested_attributes_for :approval_flows

  def copy_need_grants
    #flow_grants.map{|flow_grant| flow_grant.request_grants.build(order: flow_grant.order, role: flow_grant.role, status: :not_judged) }
    approval_flows.map{|approval_flow| approval_flow.request_grants.build(order: approval_flow.order, role: approval_flow.role, status: :not_judged) }
  end

end
