class ShopStaffsController < ApplicationController
  before_action :set_shop
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = @shop.users
  end

  def show
  end

  def csv_import
    if request.post?
      file = params[:file]
      CSV.foreach(file.path, headers: true) do |row|
        #name,external_id, external_shop_id

        shop = Shop.find_by(external_id: row['external_id'])
        user = User.find_or_create_by(external_id: row['external_id'])
        shop.update_attributes(name: row['name'])
      end
      redirect_to shops_path, notice: 'Importに成功しました'
    end
  end
  private
    def set_shop
      @shop = Shop.find(params[:shop_id])
    end

    def set_user
      @user = @shop.users.find(params[:id])
    end

end
