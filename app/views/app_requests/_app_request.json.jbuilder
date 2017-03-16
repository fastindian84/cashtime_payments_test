json.extract! app_request, :id, :title, :description, :user_name, :image_url, :amount, :order_uid, :user_uid, :status, :response, :created_at, :updated_at
json.url app_request_url(app_request, format: :json)
