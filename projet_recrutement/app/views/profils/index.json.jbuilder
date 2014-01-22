json.array!(@profils) do |profil|
  json.extract! profil, :id, :profil_title, :profil_description
  json.url profil_url(profil, format: :json)
end
