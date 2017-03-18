class FlowsController < ApplicationController
  before_action :set_flow, only: [:show, :edit, :update, :destroy, :change_default]

  # GET /flows
  # GET /flows.json
  def index
    @flows = Flow.all
  end

  # GET /flows/1
  # GET /flows/1.json
  def show
  end

  # GET /flows/new
  def new
    @flow = Flow.new
  end

  # GET /flows/1/edit
  def edit
  end

  # POST /flows
  # POST /flows.json
  def create
    @flow = Flow.new(flow_params)

    respond_to do |format|
      if @flow.save
        format.html { redirect_to @flow, notice: '申請フロー適用条件を追加しました' }
        format.json { render :show, status: :created, location: @flow }
      else
        format.html { render :new }
        format.json { render json: @flow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flows/1
  # PATCH/PUT /flows/1.json
  def update
    respond_to do |format|
      if @flow.update(flow_params)
        format.html { redirect_to @flow, notice: 'Flow was successfully updated.' }
        format.json { render :show, status: :ok, location: @flow }
      else
        format.html { render :edit }
        format.json { render json: @flow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flows/1
  # DELETE /flows/1.json
  def destroy
    @flow.destroy
    respond_to do |format|
      format.html { redirect_to flows_url, notice: 'Flow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_default
    Flow.update_all(is_default: false)
    @flow.update_attributes(is_default: true)
    redirect_to flows_url, notice: "[#{@flow.name}]をデフォルトに設定しました"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flow
      @flow = Flow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flow_params
      params.require(:flow).permit(:name, :need_evidence, 
        approval_flows_attributes: [:id, :role, :position, :_destroy], 
        executors_attributes: [:id, :role, :user_id, :_destroy])
    end
end
