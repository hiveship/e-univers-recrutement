json.array!(@users) do |user|
  json.extract! user, :id, :user_login, :user_pass, :user_mail, :user_state, :user_status
  json.url user_url(user, format: :json)
end
