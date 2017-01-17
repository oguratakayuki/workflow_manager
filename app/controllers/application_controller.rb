class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :request_statusaa
  #http://stackoverflow.com/questions/38331496/rails-5-actioncontrollerinvalidauthenticitytoken-error

  protect_from_forgery with: :exception, prepend: true

  def request_statusaa
    @user_reviewable_count = if current_user
      RequestGrant.user_reviewable(current_user).count
    else
      0
    end
  end
end
