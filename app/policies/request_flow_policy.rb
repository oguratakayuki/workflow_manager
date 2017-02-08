class RequestFlowPolicy
  include ActiveModel::Model
  class UnpermittedRequest < StandardError;end
  attr_accessor :request

  def setup_request_grants
    if @request.flow
      @request.request_grants = @request.flow.copy_need_grants
      @request.status = :reviewing
    else
      if flow = scan_flow_conditions(FlowConditionGroup.only_root)
        @request.flow = flow
      else
        @request.status = :flow_not_defined
      end
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

  def withdraw!(user)
    raise UnpermittedRequest unless withdrawable?(user)
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
    @request.status.in?(%w!flow_not_defined reviewing!) && user == @request.user
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

  #matchしなければ次へ次へと
  def scan_flow_conditions(flow_condition_groups)
    flow_condition_groups.each do |flow_condition_group|
      if conditions_matched?(flow_condition_group.condtions, flow_condition_group.relation_type)
        if flow_condition_group.child_groups
          if scan_flow_conditions(flow_condition_group.child_groups, flow_condition_group.relation_type)
            return flow_condition_group
          else
            #not matched
            next
          end
        else
          return flow_condition_group
        end
      else
        #not matched
        next
      end
    end
    #何もマッチしなかったのでここで終了
    return nil
  end

  def conditions_matched? flow_conditions, and_or
    matched_count = 0
    flow_conditions.each do |flow_condition|
      if const = Object.const_get(flow_condition.relation_type.capitalize) rescue NameError
        #categoryが
        options = flow_conditon.options.pluck(:relation_id)
        is_matched = case flow_condition.compare_type
        when 'eq' then
          #1とeqのとき
          @request.__send__(flow_condition.relation_type) == const.find(options.first)
        when 'not_eq' then
          @request.__send__(flow_condition.relation_type) != const.find(options.first)
        when 'in' then
          @request.__send__(flow_condition.relation_type) == const.where(id: options)
        when 'not_in' then
          @request.__send__(flow_condition.relation_type) != const.where(id: options)
        else
          false
        end
      else
        #price,initial_cost
        #under construction
        is_matched = true
      end
      matched_count = matched_count + 1 if is_matched
    end
    return true if and_or == 'and' && matched_count == flow_conditions.count
    return true if and_or == 'or' && matched_count > 0
    return false
  end

end
