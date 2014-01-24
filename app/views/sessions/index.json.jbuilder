json.array!(@sessions) do |session|
  json.extract! session, :id, :title, :beginDate, :endDate, :state, :description, :id_profil
  json.url session_url(session, format: :json)
end
