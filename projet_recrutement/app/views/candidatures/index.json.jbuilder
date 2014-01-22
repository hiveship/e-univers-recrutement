json.array!(@candidatures) do |candidature|
  json.extract! candidature, :id, :candidature_pseudo, :candidature_mail, :candidature_motivation, :candidature_date, :candidature_bornDate, :candidature_result
  json.url candidature_url(candidature, format: :json)
end
