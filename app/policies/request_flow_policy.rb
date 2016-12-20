class RequestFlowPolicy
  after_save :setup_request_grants
  attr_accessor :request
  def setup_request_grants
    @request.request_grants = @request.flow.copy_need_grants
    @request.save
    pass_next
  end
  def pass_next
    if request_grant = @request.request_grants.with_status(:not_active).order(:order).first
      request_grant.status = :reviewing
    else
      requst.pass_to_executor_or_creator
    end
  end
end
