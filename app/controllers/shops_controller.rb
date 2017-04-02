require 'csv'
class ShopsController < ApplicationController
  load_and_authorize_resource

  # GET /shops
  # GET /shops.json
  def index
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
  end

  # GET /shops/new
  def new
  end

  # GET /shops/1/edit
  def edit
  end

  def csv_import
    if request.post?
      file = params[:file]
      CSV.foreach(file.path, headers: true) do |row|
        #ブランド情報,店舗情報、ユーザー情報
        #brand_id,brand_name,shop_id,shop_name,user_name,user_login_id
        #shop差分確認
        brand = Brand.find_or_create_by(external_id: row['brand_id'])
        brand.assign_attributes(name: row['brand_name'])
        brand.save if brand.changed?

        shop = Shop.find_or_create_by(external_id: row['shop_id'])
        shop.assign_attributes(name: row['shop_name'])
        shop.brand = brand
        shop.save if shop.changed?

        user = User.find_or_initialize_by(login_id: row['user_login_id'])
        user.name = row['user_name']
        #userがshopに未所属なら反映
        #changed?は新規レコードでもtrueになる
        if user.changed? || !shop.in?(user.shops)
          user.password_confirmation =  user.password = SecureRandom.hex(6) if user.new_record?
          user.shops << shop if !shop.in?(user.shops)
          user.save
        end
      end
      redirect_to shops_path, notice: 'Importに成功しました'
    end
  end

  # POST /shops
  # POST /shops.json
  def create
    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(:name, :description)
    end
end
