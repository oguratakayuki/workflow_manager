module RequestDecorator
  def status_message
    if self.status.try(:reviewing?) && role = current_request_grant.try(:role)
      "#{role.text}の承認待ち"
    elsif status
      t('enumerize.request.status')[status.to_sym]
    end
  end
end
