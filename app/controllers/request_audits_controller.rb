class RequestAuditsController < ApplicationController
  def index
    @audits = Request.last.audits.order(:created_at)
    #@audits = Audit.where(auditable_type: 'Request').order(:created_at)
  end
end
