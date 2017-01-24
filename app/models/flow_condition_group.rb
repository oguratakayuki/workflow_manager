class FlowConditionGroup < ApplicationRecord
  scope :roots, -> { where(parent_id: nil) }
  has_many :childs, class_name: 'FlowConditionGroup', foreign_key: :parent_id
  belongs_to :parent, class_name: 'FlowConditionGroup', foreign_key: :id
  has_many :flow_conditions
end
