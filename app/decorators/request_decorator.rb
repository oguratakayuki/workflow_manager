module RequestDecorator
  def status_message
    if role = next_request_grant.try(:role)
      "#{role.text}の承認待ち"
    else
    end
  end
end
