module RequestDecorator
  def status_message
    if role = next_request_grant.try(:role)
      "#{role.text}の承認待ち"
    elsif status
      t('enumerize.request_grant.status')[status.to_sym]
    end
  end
end
