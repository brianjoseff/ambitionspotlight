json.array!(@task_submissions) do |task_submission|
  json.extract! task_submission, :id, :user_id, :task_id, :status
  json.url task_submission_url(task_submission, format: :json)
end
