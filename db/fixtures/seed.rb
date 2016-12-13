FlowGrant.grant_type.values.each do |grant_type|
  FlowGrant.seed do |c|
    c.grant_type = grant_type
  end
end
f = Flow.new
f.name = 'system,managerの承認が必要なflow'
f.flow_grants << FlowGrant.with_grant_type('system').first
f.flow_grants << FlowGrant.with_grant_type('manager').first
f.save

Job.seed do |j|
  j.name = '物品の購入(2000円以下)'
  j.flow = Flow.first
end
User.seed do |u|
  u.email = "test@example.com"
  u.password = "111111"
  u.password_confirmation = "111111"
end
Request.seed do |r|
  r.title = '掃除用具の購入許可申請'
  r.description = '本部で大掃除に使う'
  r.user = User.first
end

