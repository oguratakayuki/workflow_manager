module RequestDecorator
  def status_message
    if self.status.try(:reviewing?) && current_request_grant
      if current_request_grant.authenticatable_type.try(:auth_by_role?)
        "#{current_request_grant.authenticatable_role.text}の承認待ち"
      else
        "#{current_request_grant.authenticatable_user.name}の承認待ち"
      end
    elsif status
      t('enumerize.request.status')[status.to_sym]
    end
  end
  def status_color
    case status
    when 'finished'
      'success'
    when 'rejected'
      'danger'
    end
  end
end
