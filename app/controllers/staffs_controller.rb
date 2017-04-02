class StaffsController < ApplicationController
  before_action :set_user, only: [:show]
  def index
    @users = User.all
  end

  def show
  end
  private
    def set_user
      @user = @shop.users.find(params[:id])
    end

end
