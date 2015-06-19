json.array!(@endpoints) do |endpoint|
  json.extract! endpoint, :id, :name, :url, :project_id
  json.url endpoint_url(endpoint, format: :json)
end
