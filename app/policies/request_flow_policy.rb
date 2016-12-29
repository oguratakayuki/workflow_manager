class RequestFlowPolicy
  include ActiveModel::Model
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

  def update_request_grant(request_grant)
    request_grant.save
    @request.status = request_grant.status if request_grant.status == 'rejected'
    pass_next
  end

  def self.flow_editable?(flow, user)
    true if user.role.value == 'President'
    true if flow.approval_flows == []
  end

  def reject_by(user)
    request_grant = @request.request_grants.with_role(user.role).first
    request_grant.update_attributes(status: :rejected)
    @request.update_attributes(status: :rejected)
  end

  def grant_by(user)
    request_grant = @request.request_grants.with_role(user.role).first
    request_grant.update_attributes(status: :rejected, user: user)
    @request.update_attributes(status: :rejected)
  end

  def reviewable?(user)
    @request.reviewable?(user)
  end

  private
  def pass_next
    if rejected?
      @request.update_attributes(status: 'rejected')
    elsif next_flow_step_exists?
      @request.next_request_grant.update_attributes(status: :reviewing)
    elsif approval_flow_not_defined?
      #do nothing.wait for defining flow
    else
      @request.update_attributes(status: 'executable')
    end
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
