class RequestFlowPolicy
  include ActiveModel::Model
  class UnpermittedRequest < StandardError;end
  attr_accessor :request

  def setup_request_grants
    if @request.flow
      @request.request_grants = @request.flow.copy_need_grants
      @request.status = :reviewing
    else
      @request.status = :flow_not_defined
    end
    if @request.valid?
      @request.save
      pass_next
      true
    else
      false
    end
  end

  def submit!
    raise UnpermittedRequest unless submitable?
    setup_request_grants
    #TODO notifier
  end

  def withdraw!
    raise UnpermittedRequest unless withdrawable?
    Request.transaction do
      @request.update_attributes(flow: nil, status: :not_submitted)
      @request.request_grants.destroy_all
    end
  end

  def finish!
    Request.transaction do
      @request.assign_attributes(status: :finished)
      @request.save
      #TODO notifier
    end
  end



  def update_request_grant(request_grant)
    Request.transaction do
      request_grant.save
      @request.status = request_grant.status if request_grant.status == 'rejected'
      pass_next
    end
  end

  #以下cancancanに移行予定?
  def flow_editable?(user)
    true if approval_flow_not_defined? && user.role.in?(%w!system admin manager president!)
  end

  def editable?(user)
    @request.status == 'not_submitted' && user == @request.user
  end

  def reviewable?(user)
    @request.reviewable?(user)
  end

  def withdrawable?(user)
    @request.status.in?(%i!flow_not_defined reviewing!) && user == @request.user
  end

  def submitable?(user)
    @request.status == 'not_submitted' && user == @request.user
  end

  private
  def pass_next
    if rejected?
      @request.update_attributes(status: :rejected)
    elsif next_flow_step_exists?
      @request.next_request_grant.update_attributes(status: :reviewing)
    elsif approval_flow_not_defined?
      #do nothing.wait for defining flow
    elsif has_execution_flow?
      @request.update_attributes(status: :wait_for_execution)
    else
      @request.update_attributes(status: :executable)
    end
  end

  def has_execution_flow?
    @request.flow.executors.present?
  end
  def next_flow_step_exists?
    @request.next_request_grant
  end

  def approval_flow_not_defined?
    @request.status == :flow_not_defined
  end

  def rejected?
    @request.request_grants.with_status('rejected').first
  end


end
