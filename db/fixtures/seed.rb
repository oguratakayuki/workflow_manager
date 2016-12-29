
Flow.seed do |j|
  j.name = '物品の購入(2000円以下)'
end

ApprovalFlow.seed do |a|
  a.position = 1
  a.role = 'system'
  a.flow = Flow.find(1)
end
ApprovalFlow.seed do |a|
  a.position = 2
  a.role = 'manager'
  a.flow = Flow.find(1)
end


Flow.seed do |j|
  j.name = '高い買い物(50000円以上)'
end

ApprovalFlow.seed do |a|
  a.position = 1
  a.role = 'system'
  a.flow = Flow.find(2)
end
ApprovalFlow.seed do |a|
  a.position = 2
  a.role = 'manager'
  a.flow = Flow.find(2)
end
ApprovalFlow.seed do |a|
  a.position = 3
  a.role = 'president'
  a.flow = Flow.find(2)
end

(1..3).to_a.each do |index|
  User.role.values.each do |role|
    User.seed do |u|
      u.email = "#{role}#{index}@example.com"
      u.name = "#{role}#{index}太郎"
      u.role = role
      u.password = "111111"
      u.password_confirmation = "111111"
    end
  end
end

Request.seed do |r|
  r.title = '掃除用具の購入許可申請'
  r.description = '本部で大掃除に使う'
  r.user = User.first
end

