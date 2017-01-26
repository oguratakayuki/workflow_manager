class FlowConditionGroup < ApplicationRecord
  extend Enumerize
  scope :roots, -> { where(parent_id: nil) }
  has_many :childs, class_name: 'FlowConditionGroup', foreign_key: :parent_id
  belongs_to :parent, class_name: 'FlowConditionGroup', foreign_key: :id
  has_many :flow_conditions
  belongs_to :flow
  enumerize :relation_type, in: %w!and or!
  accepts_nested_attributes_for :flow_conditions, allow_destroy: true
end
