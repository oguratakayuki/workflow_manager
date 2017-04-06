class UserForm
  include ActiveModel::Model
  extend Enumerize

  attr_accessor :brand_ids, :shop_ids, :login_id, :name
  def search
    @query = User.all
    @query = @query.by_brands(@brand_ids) if @brand_ids.present?
    @query = @query.by_shops(@shop_ids) if @shop_ids.present?
    @query = @query.where(login_id: @login_id) if @login_id.present?
    @query = @query.where(name: @name) if @name.present?
    @query
  end
  def brand_ids=(brand_ids)
    @brand_ids =  brand_ids.reject(&:blank?)
  end
  def shop_ids=(shop_ids)
    @shop_ids =  shop_ids.reject(&:blank?)
  end

end


