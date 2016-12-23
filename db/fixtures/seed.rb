FlowGrant.role.values.each.with_index do |role, index|
  FlowGrant.seed do |c|
    c.role = role
  end
end
f = Flow.new
f.name = 'system,managerの承認が必要なflow'
f.flow_grants << FlowGrant.with_role('system').first
f.flow_grants << FlowGrant.with_role('manager').first
f.save

f = Flow.new
f.name = '社長決済が必要なflow'
f.flow_grants << FlowGrant.with_role('system').first
f.flow_grants << FlowGrant.with_role('manager').first
f.flow_grants << FlowGrant.with_role('president').first
f.save


Job.seed do |j|
  j.name = '物品の購入(2000円以下)'
  j.flow = Flow.first
end

Job.seed do |j|
  j.name = '高い買い物(50000円以上)'
  j.flow = Flow.last
end



FlowGrant.role.values.each do |role|
  User.seed do |u|
    u.email = "#{role}@example.com"
    u.name = "#{role}太郎"
    u.role = role
    u.password = "111111"
    u.password_confirmation = "111111"
  end
end

Request.seed do |r|
  r.title = '掃除用具の購入許可申請'
  r.description = '本部で大掃除に使う'
  r.user = User.first
end

