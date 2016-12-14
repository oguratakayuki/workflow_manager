json.extract! request, :id, :job_id, :user_id, :title, :description, :created_at, :updated_at
json.url request_url(request, format: :json)
