class RequestFlowPolicy
  include ActiveModel::Model
  class UnpermittedRequest < StandardError;end
  attr_accessor :request

  def save_request_and_select_flow
    if @request.save
      if flow = find_flow(FlowConditionGroup.only_root)
        @request.flow = flow
        @request.status = :reviewing
        @request.request_grants = flow.copy_need_grants
        @request.save
        pass_next
      else
        @request.update_attributes(status: :flow_not_defined)
      end
      true
    else
      false
    end
  end

  def submit!
    #raise UnpermittedRequest unless submitable?
    #setup_request_grants
    save_request_and_select_flow
    #TODO notifier
  end

  def withdraw!(user)
    #raise UnpermittedRequest unless withdrawable?(user)
    Request.transaction do
      @request.update_attributes(flow: nil, status: :not_submitted)
      @request.request_grants.destroy_all
    end
  end

  def executed!(executed_user_id)
    @request.execution_evidences.each{|t| t.upload_user_id = executed_user_id }
    Request.transaction do
      @request.assign_attributes(status: :finished)
      @request.save
      #TODO notifier
    end
  end

  def hide!(user)
    @request.update_attributes(displayable: false)
  end

  def finish!
    Request.transaction do
      @request.assign_attributes(status: :finished)
      @request.save
      #TODO notifier
    end
  end

  def update_request_grant(request_grant, user_id)
    Request.transaction do
      request_grant.authenticated_user_id = user_id
      request_grant.save
      @request.status = request_grant.status if request_grant.status == 'rejected'
      pass_next
    end
  end

  #以下cancancanに移行予定?
  #特権ユーザーのみ直接flowを決定できる
  def self.accessible_request_grants(user, action, options={})
    if user
      case action
      when :review
        RequestGrant.reviewable(user)
      else
        raise StandardError
      end
    else
      []
    end
  end

  def self.accesible_request_grant?(request_grant, user, action)
    return [] unless user
    request_grants = case action
    when :review
      self.accessible_request_grants(user, action, options={})
    else
      raise StandardError
    end
    request_grant.in?(request_grants)
  end

  def self.accessible_request(id, user, action, options={})
    request = self.accessible_requests(user, action, options).where(id: id).first
    raise RequestFlowPolicy::UnpermittedRequest if request.nil?
    request
  end

  def self.accessible_requests(user, action, options={})
    if user
      case action
      when :destroy
        Request.by_user(user)
      when :hide
        Request.by_user(user).displayable(true)
      when :execute
        if user.role.in?(%w!admin manager system operator!)
          Request.executable(user)
        else
          Request.none
        end
      when :show
        if options[:with_undisplayable]
          Request.by_user(user)
        else
          Request.by_user(user).displayable(true)
        end
      when :define_flow
        if user.role.in?(%w!admin manager system operator!)
          Request.where(status: :flow_not_defined)
        else
          Request.none
        end
      when :edit
        Request.with_status(:not_submitted).by_user(user)
      when :submit
        Request.with_status(:not_submitted).by_user(user)
      when :delete
        Request.where(status: %i(finished rejected)).by_user(user)
      when :withdraw
        Request.where(status: %i(flow_not_defined reviewing)).by_user(user)
      else
        raise StandardError
      end
    else
      Request.none
    end
  end

  def self.accesible_request?(request, user, action)
    return [] unless user
    requests = case action
    when :edit
      self.accessible_requests(user, action, options={})
    when :submit
      self.accessible_requests(user, action, options={})
    when :delete
      self.accessible_requests(user, action, options={})
    when :withdraw
      self.accessible_requests(user, action, options={})
    when :define_flow
      self.accessible_requests(user, action, options={})
    else
      raise StandardError
    end
    request.in?(requests)
  end

  private
  def pass_next
    if rejected?
      @request.update_attributes(status: :rejected)
    elsif next_flow_step_exists?
      @request.next_request_grant.update_attributes(status: :reviewing)
    elsif approval_flow_not_defined?
      #do nothing.wait for defining flow
    elsif has_executable_flow?
      @request.update_attributes(status: :wait_for_execution)
    else
      @request.update_attributes(status: :finished)
    end
  end

  def has_executable_flow?
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

  def find_flow(root_flow_condition_groups)
    flow = root_flow_condition_groups.detect {|root_flow_condition_group| scan_flow_conditions root_flow_condition_group}.try(:flow)
    flow = Flow.default.first unless flow.present?
    flow
  end
  #matchしなければ次へ次へと
  def scan_flow_conditions(flow_condition_group)
    if conditions_matched?(flow_condition_group.flow_conditions, flow_condition_group.relation_type)
      Rails.logger.debug 'Policy: conditions matched'
      if flow_condition_group.childs.present?
        #子レコードがあればチェック
        Rails.logger.debug "Policy:  flow_condition_group has childs: id =  #{flow_condition_group.id}"
        Rails.logger.debug "Policy:  flow_condition_group has childs: id =  #{flow_condition_group.childs.ids}"
        #if scan_flow_conditions(flow_condition_group.childs, flow_condition_group.relation_type)
        flow_condition_group.childs.each do |flow_condition_group|
          return false if scan_flow_conditions(flow_condition_group) == false
        end
      end
      return true
    else
      Rails.logger.debug 'Policy: conditions not matched'
      #not matched
    end
    #何もマッチしなかったのでここで終了
    false
  end

  def conditions_matched? flow_conditions, and_or
    matched_count = 0
    flow_conditions.each do |flow_condition|
      if const = Object.const_get(flow_condition.related_model.camelize) rescue nil 
        Rails.logger.debug "Policy: in condition_matched?: const = #{const.inspect}"
        #categoryが
        options = flow_condition.flow_condition_options.pluck(:relation_id).map(&:to_i)
        is_matched = case flow_condition.compare_type
        when 'eq' then
          #1とeqのとき
          ret = @request.__send__(flow_condition.related_model) == const.find(options.first)
          Rails.logger.debug "Policy: in condition_matched?: type eq, ret  = #{ret}"
          ret
        when 'not_eq' then
          ret = @request.__send__(flow_condition.related_model) != const.find(options.first)
          Rails.logger.debug "Policy: in condition_matched?: type not eq, ret  = #{ret}"
          ret
        when 'in' then
          if related_model = @request.__send__(flow_condition.related_model)
            ret = related_model.id.in?(options)
            Rails.logger.debug "hree" + @request.__send__(flow_condition.related_model).id.inspect
            Rails.logger.debug "hree" + options.inspect
          else
            ret = false
          end
          Rails.logger.debug "Policy: in condition_matched?: type in, ret  = #{ret}"
          ret
        when 'not_in' then
          if related_model = @request.__send__(flow_condition.related_model)
            ret = !related_model.id.in?(options)
            Rails.logger.debug "hree" + @request.__send__(flow_condition.related_model).id.inspect
            Rails.logger.debug "hree" + options.inspect
          else
            ret = false
          end
          Rails.logger.debug "Policy: in condition_matched?: type not in, ret  = #{ret}"
        else
          Rails.logger.debug "Policy: in condition_matched?: type undefined return false"
          false
        end
      else
        related_type = flow_condition.related_model.to_sym
        Rails.logger.debug "related_type = #{related_type}"
        if related_type.in?(%i(money_cost initial_cost))
          values = flow_condition.flow_condition_options.pluck(:compare_value).map(&:to_i)
          Rails.logger.debug "Policy: in condition_matched?: values  = #{values.inspect}"
          is_matched = case flow_condition.compare_type
          when 'eq' then
            #1とeqのとき
            ret = @request.associated_value(related_type) == values.first
            Rails.logger.debug "Policy: in condition_matched?: type eq, ret  = #{ret}"
            ret
          when 'not_eq' then
            ret = @request.associated_value(related_type) != values.first
            Rails.logger.debug "Policy: in condition_matched?: type not eq, ret  = #{ret}"
            ret
          when 'in' then
            ret = @request.associated_value(related_type).in?(values)
            Rails.logger.debug "hree" + @request.__send__(flow_condition.related_model).id.inspect
            Rails.logger.debug "hree" + options.inspect
            Rails.logger.debug "Policy: in condition_matched?: type in, ret  = #{ret}"
            ret
          when 'not_in' then
            ret = @request.associated_value(related_type).in?(values)
            Rails.logger.debug "Policy: in condition_matched?: type not in, ret  = #{ret}"
            ret
          when 'gt_eq' then
            ret = @request.associated_value(related_type) >= values.first
            Rails.logger.debug "Policy: in condition_matched?: type [gt_eq], ret  = #{ret}"
            Rails.logger.debug "Policy: in condition_matched?: type [gt_eq], ret  = #{ret}"
            Rails.logger.debug "Policy: in condition_matched?: type [gt_eq], params value  = #{@request.associated_value(related_type)}"
            Rails.logger.debug "Policy: in condition_matched?: type [gt_eq], defined value  = #{values.first}"
            ret
          when 'lt_eq' then
            ret = @request.associated_value(related_type) <= values.first
            Rails.logger.debug "Policy: in condition_matched?: type [lt_eq], ret  = #{ret}"
            Rails.logger.debug "Policy: in condition_matched?: type [lt_eq], params value  = #{@request.associated_value(related_type)}"
            Rails.logger.debug "Policy: in condition_matched?: type [lt_eq], defined value  = #{values.first}"
            ret
          else
            Rails.logger.debug "Policy: in condition_matched?: type undefined return false"
            false
          end
        end
        #Rails.logger.debug "Policy: in condition_matched?: under construction"
        ##price,initial_cost
        ##under construction
        #is_matched = true
      end
      matched_count = matched_count + 1 if is_matched
    end
    Rails.logger.debug "and or: #{and_or}"
    Rails.logger.debug "matched_count = #{matched_count}"
    Rails.logger.debug "flow_conditions.count = #{flow_conditions.count}"
    return true if and_or == 'and' && matched_count == flow_conditions.count
    return true if and_or == 'or' && matched_count > 0
    return true if and_or.nil? && matched_count > 0
    return false
  end

end
