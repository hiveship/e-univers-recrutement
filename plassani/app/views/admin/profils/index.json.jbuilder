json.array!(@profils) do |profil|
  json.extract! profil, :id, :title, :description
  json.url profil_url(profil, format: :json)
end
