json.array!(@evaluations) do |evaluation|
  json.extract! evaluation, :id, :eval_mark, :eval_commentary
  json.url evaluation_url(evaluation, format: :json)
end
