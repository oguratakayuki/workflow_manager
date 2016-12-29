class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :update, :destroy, :reject, :grant, :review, :report]

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.where(user: current_user)
    @reviewable_requests = Request.reviewable_by_role(current_user.role)
    @executable_requests = Request.executable_request_grant(current_user)
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  def review
    render :show
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

  def report
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    if RequestFlowPolicy.new(request: @request).setup_request_grants
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
      params.require(:request).permit(:flow_id, :user_id, :title, :description)
    end

    def request_finish_report_params
      params.require(:request).permit(:status, evidences_attributes: [
        :_destroy,
        :id,
        :file_name,
        ])
    end


end
