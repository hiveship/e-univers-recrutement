json.array!(@sessions) do |session|
  json.extract! session, :id, :title, :beginDate, :endDate, :state, :description, :id_profil
  json.url session_url(session, format: :json)
end


<div class="progress progress-striped active">
                    <<div class="bar" style="width: <%= ((session.endDate-session.beginDate) / session.endDate) %> %;"></div>
                </div>