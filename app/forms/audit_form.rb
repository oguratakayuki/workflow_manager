class AuditForm
  include ActiveModel::Model
  extend Enumerize

  attr_accessor :audit_type, :audit_id
  enumerize :audit_type, in: %i(request shop user), scope: true
  def search
    const = Object.const_get(@audit_type.camelize) rescue nil 
    const ||= Request
    const = const.joins(:audits)
    @results = @audit_id.present? ? const.where(id: @audit_id) : const.all
  end
end


