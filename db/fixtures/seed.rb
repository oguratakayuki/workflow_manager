FlowGrant.grant_type.values.each do |grant_type|
  FlowGrant.seed do |c|
    c.grant_type = grant_type
  end
end
 
