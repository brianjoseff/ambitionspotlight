json.array!(@goals) do |goal|
  json.extract! goal, :id, :title, :goal_category_id
  json.url goal_url(goal, format: :json)
end
