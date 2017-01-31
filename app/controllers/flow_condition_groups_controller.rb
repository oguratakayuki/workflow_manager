class FlowConditionGroupsController < ApplicationController
  before_action :set_flow_condition_gourp, only: [:show, :edit, :update]
  def new
    @flow_condition_group = FlowConditionGroup.new
  end
  def index
    @flow_condition_groups = FlowConditionGroup.roots
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @flow_condition_group.update(flow_condition_group_params)
        format.html { redirect_to @flow_condition_group, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @flow_condition_group }
      else
        format.html { render :edit }
        format.json { render json: @flow_condition_group.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flow_condition_gourp
      @flow_condition_group = FlowConditionGroup.roots.find(params[:id])
    end

    def flow_condition_group_params
      params.require(:flow_condition_group).permit(:flow_id, :parent_id,:relation_type,
        flow_conditions_attributes: [
        :id,
        :flow_condition_group_id,
        :_destroy,
        :relation_type,
        :compare_type,
          flow_condition_options_attributes: [
            :relation_id, 
            :_destroy
          ]
        ]
      )
    end

end
