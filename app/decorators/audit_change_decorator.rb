class AuditChangeDecorator
  include ActiveModel::Model
  attr_accessor :column, :raw_before_after, :audit
  def initialize(*params)
    debugger
    super(params)
  end
  def info_exists?
    @before_after[1].present?
  end
  def subject_column_name
    Object.const_get(@audit.auditable_type).human_attribute_name(@column) 
  end
  def update_info?
    #@before_after[1].is_a?(Array)
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
