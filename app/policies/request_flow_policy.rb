class RequestFlowPolicy
  include ActiveModel::Model
  attr_accessor :request
  def setup_request_grants
    @request.request_grants = @request.job.flow.copy_need_grants
    @request.save
    pass_next
  end

  def update_request_grant(request_grant)
    request_grant.save
    @request.status = request_grant.status if request_grant.status == 'rejected'
    pass_next
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
    elsif request_grant = @request.next_request_grant
      request_grant.update_attributes(status: :reviewing)
    else
      @request.update_attributes(status: 'executable')
    end
  end

  def rejected?
    @request.request_grants.with_status('rejected').first
  end


end
