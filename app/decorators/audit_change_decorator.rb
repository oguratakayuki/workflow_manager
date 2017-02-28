class AuditChangeDecorator
  include ActiveModel::Model
  attr_accessor :column, :raw_before_after, :audit, :before, :after
  def initialize *params
    if params.first[:raw_before_after].is_a?(Array)
      @raw_before = params.first[:raw_before_after][0]
      @raw_after = params.first[:raw_before_after][1]
    else
      @first_value_for_created_record = params.first[:raw_before_after]
    end
    super *params
  end


  def info_exists?
    @raw_before_after.is_a?(Array) || @first_value_for_created_record
  end
  def subject_column_name
    Object.const_get(@audit.auditable_type).human_attribute_name(@column) 
  end
  def update_info?
    @raw_before && @raw_after
  end
  def associated?
    Object.const_get(@audit.auditable_type).try(@column)
  end
  def association_options
    options = Object.const_get(@audit.auditable_type).__send__(@column).try(:options)
  end
  def associated_before_after
    ret = [@raw_before, @raw_after].map{|t| association_options.find{|a,b| b == t}.try(:[], 0) }
  end
  def before
    @raw_before || '未設定'
  end

  def after
    @raw_after || '未設定'
  end
  def first_value_for_created_record
    @first_value_for_created_record || '未設定'
  end
end
