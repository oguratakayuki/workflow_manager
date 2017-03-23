class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy, :reject, :grant, :review, :define_flow, :update_flow, :withdraw, :submit, :audit, :report, :execution_report]
  #load_and_authorize_resource

  # GET /requests
  # GET /requests.json
  def index
    with_finished = params[:with_finished]
    @requests = RequestFlowPolicy.displayable_requests_by_user(current_user, with_finished)
  end

  def audit
    @audits = @request.audits.order(:created_at)
  end

  def executable
    @requests = if current_user.role.in? %w!admin manager system!
      Request.executable(current_user)
    else
      []
    end
  end

  def flow_not_defined
    @requests = if current_user.role.in? %w!admin manager system!
      Request.where(status: :flow_not_defined)
    else
      []
    end
  end

  def edit
    unless RequestFlowPolicy.new(request: @request).editable?(current_user)
      redirect_to @request, notice: '一度申請を取り消さないと編集できません'
    end
  end

  def define_flow
  end

  def update_flow
    @request.assign_attributes(define_flow_params)
    if RequestFlowPolicy.new(request: @request).save_request_and_select_flow
      redirect_to @request, notice: 'Request was successfully updated.'
    else
      render :edit
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  def review
    render :show
  end


  def withdraw
    RequestFlowPolicy.new(request: @request).withdraw!(current_user)
    redirect_to requests_path, notice: '申請を取り消しました'
  end

  def submit
    RequestFlowPolicy.new(request: @request).save_request_and_select_flow
    redirect_to requests_path, notice: '申請を提出しました'
  end

  def reject
    RequestFlowPolicy.new(request: @request).reject_by(current_user)
  end

  def grant
    RequestFlowPolicy.new(request: @request).reject_by(current_user)
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  def execution_report
    if request.patch?
      @request.assign_attributes(request_params)
      if RequestFlowPolicy.new(request: @request).executed!(current_user.id)
        redirect_to @request, notice: '申請者に通知しました'
      else
        render :report
      end
    end
  end

  def report
    if request.patch?
      @request.assign_attributes(request_params)
      if RequestFlowPolicy.new(request: @request).finish!
        redirect_to @request, notice: '管理部に通知しました'
      else
        render :report
      end
    end
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    authorize! :create, @request
    if RequestFlowPolicy.new(request: @request).save_request_and_select_flow
      redirect_to requests_path, notice: '申請が完了しました'
    else
      render :new
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:flow_id, :user_id, :category_id, :sub_category_id, :title, :description,
        money_cost_attributes: [
          :id,
          :request_id,
          :_destroy,
          :cost_value,
          :annotation,
        ], 
        costs_attributes: [
          :_destroy,
          :initial_cost,
          :price,
          :time_required,
          :person_number, 
          :cost_price_type
        ], 
        initial_money_cost_attributes: [
          :id,
          :request_id,
          :_destroy,
          :cost_value,
          :annotation,
        ], 
        monthly_money_cost_attributes: [
          :id,
          :_destroy,
          :cost_value,
          :annotation,
        ], 
        annual_money_cost_attributes: [
          :id,
          :_destroy,
          :cost_value,
          :annotation,
        ], 
        initial_human_cost_attributes: [
          :id,
          :_destroy,
          :time_required,
          :number_of_people,
          :annotation,
        ], 
        monthly_human_cost_attributes: [
          :id,
          :_destroy,
          :time_required,
          :number_of_people,
          :annotation,
        ], 
        annual_human_cost_attributes: [
          :id,
          :_destroy,
          :time_required,
          :number_of_people,
          :annotation,
        ], 
        finishing_evidences_attributes: [
          :_destroy,
          :id,
          :comment,
          :file_name,
          :remove_file_name,
        ],
        execution_evidences_attributes: [
          :_destroy,
          :id,
          :comment,
          :file_name,
          :remove_file_name,
        ],
      )
    end

    def define_flow_params
      params.require(:request).permit(:flow_id)
    end

end

