class FlowCondition < ApplicationRecord
  extend Enumerize
  belongs_to :flow_condition_group
  enumerize :relation_type, in: %w!shop category sub_category price initial_cost time_required personal_number!, scope: true
  enumerize :compare_type, in: %w!eq not_eq in not_in!, scope: true
  belongs_to :flow_condition_group
  has_many :flow_condition_options
  accepts_nested_attributes_for :flow_condition_options, allow_destroy: true
end
