json.extract! request, :id, :job_id, :zen_user_id, :title, :description, :created_at, :updated_at
json.url request_url(request, format: :json)