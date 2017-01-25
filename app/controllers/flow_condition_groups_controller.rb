class FlowConditionGroupsController < ApplicationController
  before_action :set_flow_condition_gourp, only: [:show, :edit, :index]
  def index
    @flow_condition_groups = FlowConditionGroup.roots
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flow_condition_gourp
      @flow_condition_group = FlowConditionGroup.roots.find(params[:id])
    end

end
