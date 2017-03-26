class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :request_status
  before_action :configure_permitted_parameters, if: :devise_controller?
  #http://stackoverflow.com/questions/38331496/rails-5-actioncontrollerinvalidauthenticitytoken-error

  protect_from_forgery with: :exception, prepend: true

  def request_status
    @user_reviewable_count          = RequestFlowPolicy.accessible_request_grants(current_user, :review).count
    @user_executable_count          = RequestFlowPolicy.accessible_requests(current_user, :execute).count
    @flow_not_defined_request_count = RequestFlowPolicy.accessible_requests(current_user, :define_flow).count
  end

  rescue_from CanCan::AccessDenied, RequestFlowPolicy::UnpermittedRequest do |exception|
    redirect_to :root, alert: 'アクセス権がありません'
  end

  before_action do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  protected
  def configure_permitted_parameters
    added_attrs = [:login_id, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end


end
