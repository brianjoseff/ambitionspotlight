json.array!(@lists) do |list|
  json.extract! list, :id, :user_id, :description
  json.url list_url(list, format: :json)
end
