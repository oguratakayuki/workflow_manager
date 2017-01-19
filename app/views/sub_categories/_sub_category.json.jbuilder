json.extract! sub_category, :id, :category_id, :name, :created_at, :updated_at
json.url category_sub_category_url(category, sub_category, format: :json)
