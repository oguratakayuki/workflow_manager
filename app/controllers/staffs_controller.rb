class StaffsController < ApplicationController
  before_action :set_user, only: [:show]
  def index
    @user_form = UserForm.new(user_form_params)
    @users = @user_form.search 
  end

  def show
  end
  private
    def set_user
      @user = @shop.users.find(params[:id])
    end

    def user_form_params
      params.require(:user_form).permit(:login_id, :name, :shop_ids => [], :brand_ids => [])
    rescue ActionController::ParameterMissing
      nil
    end

end
