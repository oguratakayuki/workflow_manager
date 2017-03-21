class Flow < ApplicationRecord
  has_many :executors, class_name: 'FlowExecutor'
  has_many :approval_flows, inverse_of: :flow
  has_one :flow_condition_group
  accepts_nested_attributes_for :approval_flows, allow_destroy: true
  accepts_nested_attributes_for :executors, allow_destroy: true
  scope :default, -> { where(is_default: true) }

  def copy_need_grants
    approval_flows.map{|approval_flow| approval_flow.request_grants.build(position: approval_flow.position, authenticatable_role: approval_flow.authenticatable_role, authenticatable_user_id: approval_flow.authenticatable_user_id, status: :not_judged) }
  end

end
