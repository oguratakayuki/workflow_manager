class AuditsController < ApplicationController

  # GET /shops
  # GET /shops.json
  def index
    @audit_form = AuditForm.new(audit_params)
    @results = @audit_form.search
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def audit_params
      params.require(:audit_form).permit(:audit_type, :audit_id)
    rescue ActionController::ParameterMissing
      nil
    end
end
