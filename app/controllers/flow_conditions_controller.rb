class FlowConditionsController < ApplicationController
  def index
    @flow_conditions = FlowConditionGroup.roots
  end
end
