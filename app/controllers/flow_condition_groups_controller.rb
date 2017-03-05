class FlowConditionGroupsController < ApplicationController
  before_action :set_flow
  before_action :set_flow_condition_gourp, only: [:show, :edit, :update, :destroy, :new]
  def new
  end
  def index
    @flow_condition_groups = FlowConditionGroup.only_root
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @flow_condition_group.update(flow_condition_group_params)
        format.html { redirect_to flows_path, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @flow_condition_group }
      else
        format.html { render :edit }
        format.json { render json: @flow_condition_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @flow_condition_group = FlowConditionGroup.new(flow_condition_group_params)

    respond_to do |format|
      if @flow_condition_group.save
        format.html { redirect_to flows_path, notice: 'Flow was successfully created.' }
        format.json { render :show, status: :created, location: @flow_condition_group }
      else
        format.html { render :new }
        format.json { render json: @flow_condition_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @flow_condition_group.destroy
    respond_to do |format|
      format.html { redirect_to flow_path, notice: 'FlowConditionGroup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flow
      @flow = Flow.find(params[:flow_id])
    end
    def set_flow_condition_gourp
      @flow_condition_group = @flow.flow_condition_group || @flow.build_flow_condition_group
    end

    def flow_condition_group_params
      params.require(:flow_condition_group).permit(:flow_id, :parent_id,:relation_type,
        flow_conditions_attributes: [
        :id,
        :flow_condition_group_id,
        :_destroy,
        :related_model,
        :compare_type,
          flow_condition_options_attributes: [
            :id,
            :relation_id, 
            :compare_value,
            :_destroy
          ]
        ]
      )
    end

end
