json.array!(@daily_accomplishments) do |daily_accomplishment|
  json.extract! daily_accomplishment, :id, :content
  json.url daily_accomplishment_url(daily_accomplishment, format: :json)
end
