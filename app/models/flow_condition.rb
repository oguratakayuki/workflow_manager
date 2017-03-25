class FlowCondition < ApplicationRecord
  extend Enumerize
  belongs_to :flow_condition_group
  enumerize :related_model, in: %w!shop category sub_category money_cost!, scope: true
  enumerize :compare_type, in: %w!eq not_eq lt_eq gt_eq in not_in!, scope: true
  belongs_to :flow_condition_group
  has_many :flow_condition_options
  accepts_nested_attributes_for :flow_condition_options, allow_destroy: true
end
