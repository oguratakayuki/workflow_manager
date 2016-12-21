class RequestFlowPolicy
  include ActiveModel::Model
  attr_accessor :request
  def setup_request_grants
    @request.request_grants = @request.job.flow.copy_need_grants
    @request.save
    pass_next
  end
  def pass_next
    if request_grant = @request.next_request_grant
      request_grant.update_attributes(status: :reviewing)
    else
      @requst.pass_to_executor_or_creator
    end
  end
end
