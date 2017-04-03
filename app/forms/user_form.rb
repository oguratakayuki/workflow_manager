class UserForm
  include ActiveModel::Model
  extend Enumerize

  attr_accessor :brand_ids, :shop_ids, :login_id, :name
  def search
    @query = User.where
    @query = @query.by_brands(@brand_ids) if @brand_ids.present?
    @query = @query.by_shops(@shopids) if @shop_ids.present?
    @query = @query.where(login_id: @login_id) if @login_id
    @query = @query.where(name: @name) if @name
    @query
  end
end


