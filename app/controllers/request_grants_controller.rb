class RequestGrantsController < ApplicationController
  before_action :set_request, only: [:review, :update]
  before_action :set_request_grant, only: [:review, :update]

  def index
    @request_grants = RequestGrant.user_reviewable(current_user)
  end



  def review
    render :show
  end

  def update 
    @request_grant.assign_attributes(request_grant_params)
    if RequestFlowPolicy.new(request: @request).update_request_grant(@request_grant)
      redirect_to requests_path, notice: '承認処理が完了しました'
    else
      render :show
    end
  end

  def grant
    RequestFlowPolicy.new(request: @request).reject_by(current_user)
  end

  private
    def set_request
      @request = Request.find(params[:request_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_request_grant
      @request_grant = RequestGrant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_grant_params
      params.require(:request_grant).permit(:user_id, :status, :comment)
    end
end
