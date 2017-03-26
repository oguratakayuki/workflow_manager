
Flow.seed do |j|
  j.name = '物品の購入(2000円以下)'
  j.is_default = true
end

ApprovalFlow.seed do |a|
  a.position = 1
  a.authenticatable_type = 'auth_by_role'
  a.authenticatable_role = 'system'
  a.flow_id = 1
end
ApprovalFlow.seed do |a|
  a.position = 2
  a.authenticatable_type = 'auth_by_role'
  a.authenticatable_role = 'manager'
  a.flow_id = 1
end


Flow.seed do |j|
  j.name = '高い買い物(50000円以上)'
end

ApprovalFlow.seed do |a|
  a.position = 1
  a.authenticatable_type = 'auth_by_role'
  a.authenticatable_role = 'system'
  a.flow_id = 2
end
ApprovalFlow.seed do |a|
  a.position = 2
  a.authenticatable_type = 'auth_by_role'
  a.authenticatable_role = 'manager'
  a.flow_id = 2
end
ApprovalFlow.seed do |a|
  a.position = 3
  a.authenticatable_type = 'auth_by_role'
  a.authenticatable_role = 'president'
  a.flow_id = 2
end

(1..3).to_a.each do |index|
  User.role.values.each do |role|
    User.seed do |u|
      u.login_id = "#{role}#{index}"
      u.name = "#{role}#{index}太郎"
      u.role = role
      u.password = "111111"
      u.password_confirmation = "111111"
    end
  end
end

%w(物品の購入 データ修正 レッスン受講).to_a.each do |name|
  Category.seed do |category|
    category.name = name
  end
end
(1..3).to_a.each do |index|
  SubCategory.seed do |sub_category|
    sub_category.category_id = index
    sub_category.name = "サブカテゴリ#{index}"
  end
end

Request.seed do |r|
  r.title = '掃除用具の購入許可申請'
  r.description = '本部で大掃除に使う'
  r.user = User.first
  category = Category.first
  r.category = category 
  r.sub_category = category.sub_categories.first
end

