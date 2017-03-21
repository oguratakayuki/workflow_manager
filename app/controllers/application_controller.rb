class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :request_status
  #http://stackoverflow.com/questions/38331496/rails-5-actioncontrollerinvalidauthenticitytoken-error

  protect_from_forgery with: :exception, prepend: true

  def request_status
    @user_reviewable_count = current_user ?  RequestGrant.user_reviewable(current_user).count : 0
    @user_executable_count = current_user ?  Request.executable(current_user).count : 0
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :root, alert: 'アクセス権がありません'
  end

  before_action do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end



end
