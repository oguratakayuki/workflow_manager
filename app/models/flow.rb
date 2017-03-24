class Flow < ApplicationRecord
  has_many :executors, class_name: 'FlowExecutor'
  has_many :approval_flows, inverse_of: :flow
  has_one :flow_condition_group
  accepts_nested_attributes_for :approval_flows, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :executors, allow_destroy: true, reject_if: :all_blank
  scope :default, -> { where(is_default: true) }

  validates :name, presence: :true

  def copy_need_grants
    approval_flows.map do |approval_flow|
      approval_flow.request_grants.build(
        position: approval_flow.position, 
        authenticatable_type: approval_flow.authenticatable_type, 
        authenticatable_role: approval_flow.authenticatable_role, 
        authenticatable_user_id: approval_flow.authenticatable_user_id, 
        status: :not_judged
      )
    end
  end

end
