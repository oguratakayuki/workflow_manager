module RequestGrantDecorator
  def status_label_class
    case self.status
    when 'not_judged' then
      'label label-default'
    when 'reviewing' then
      'label label-primary'
    when 'granted' then
      'label label-success'
    when 'rejected' then
      'label label-danger'
    end
  end
end
