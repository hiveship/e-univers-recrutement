json.array!(@users) do |user|
  json.extract! user, :id, :login, :pass, :mail, :state, :status
  json.url user_url(user, format: :json)
end
