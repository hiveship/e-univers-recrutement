json.array!(@candidatures) do |candidature|
  json.extract! candidature, :id, :pseudo, :mail, :motivation, :submitDate, :bornDate, :result, :id_session
  json.url candidature_url(candidature, format: :json)
end
