json.array!(@sessions) do |session|
  json.extract! session, :id, :sess_title, :sess_beginDate, :sess_endDate, :sess_state, :sess_description
  json.url session_url(session, format: :json)
end
