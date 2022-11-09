json.extract! payment, :id, :precio, :aceptado, :request, :response, :created_at, :updated_at
json.url payment_url(payment, format: :json)
