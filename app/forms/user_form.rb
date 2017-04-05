class UserForm
  include ActiveModel::Model
  extend Enumerize

  attr_accessor :brand_ids, :shop_ids, :login_id, :name
  def search
    @queries = []
    @queries << User.by_brands(@brand_ids) if @brand_ids.present?
    @queries << User.by_shops(@shop_ids) if @shop_ids.present?
    @queries << User.where(login_id: @login_id) if @login_id
    @queries << User.where(name: @name) if @name
    @queries.reduce(:+) || User.all
  end
end


