class StaffsController < ApplicationController
  before_action :set_user, only: [:show]
  def index
    @user_form = UserForm.new(params[:q])
    @users = @user_form.search 
  end

  def show
  end
  private
    def set_user
      @user = @shop.users.find(params[:id])
    end

end
