class FlowGrantsController < ApplicationController
  before_action :set_flow_grant, only: [:show, :edit, :update, :destroy]

  # GET /flow_grants
  # GET /flow_grants.json
  def index
    @flow_grants = FlowGrant.all
  end

  # GET /flow_grants/1
  # GET /flow_grants/1.json
  def show
  end

  # GET /flow_grants/new
  def new
    @flow_grant = FlowGrant.new
  end

  # GET /flow_grants/1/edit
  def edit
  end

  # POST /flow_grants
  # POST /flow_grants.json
  def create
    @flow_grant = FlowGrant.new(flow_grant_params)

    respond_to do |format|
      if @flow_grant.save
        format.html { redirect_to @flow_grant, notice: 'Flow grant was successfully created.' }
        format.json { render :show, status: :created, location: @flow_grant }
      else
        format.html { render :new }
        format.json { render json: @flow_grant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flow_grants/1
  # PATCH/PUT /flow_grants/1.json
  def update
    respond_to do |format|
      if @flow_grant.update(flow_grant_params)
        format.html { redirect_to @flow_grant, notice: 'Flow grant was successfully updated.' }
        format.json { render :show, status: :ok, location: @flow_grant }
      else
        format.html { render :edit }
        format.json { render json: @flow_grant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flow_grants/1
  # DELETE /flow_grants/1.json
  def destroy
    @flow_grant.destroy
    respond_to do |format|
      format.html { redirect_to flow_grants_url, notice: 'Flow grant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flow_grant
      @flow_grant = FlowGrant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flow_grant_params
      params.require(:flow_grant).permit(:order, :grant_type)
    end
end
