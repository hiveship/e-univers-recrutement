json.array!(@evaluations) do |evaluation|
  json.extract! evaluation, :id, :mark, :commentary, :id_candidature, :id_user
  json.url evaluation_url(evaluation, format: :json)
end
