json.extract! flow_grant, :id, :order, :grant_type, :created_at, :updated_at
json.url flow_grant_url(flow_grant, format: :json)