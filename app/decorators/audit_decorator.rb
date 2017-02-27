class AuditDecorator
  include ActiveModel::Model
  attr_accessor :object
  def method_missing(m, *args, &block)
    @object.send(m, *args, &block)
  end

  def audited_changes
    @object.audited_changes.map{|t| AuditChangeDecorator.new(column: t[0], raw_before_after: t[1], audit: self) }
  end
end

