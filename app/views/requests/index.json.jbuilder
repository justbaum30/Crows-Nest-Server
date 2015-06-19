json.array!(@requests) do |request|
  json.extract! request, :id, :name, :header, :body, :endpoint_id
  json.url request_url(request, format: :json)
end
