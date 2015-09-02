json.user do
  json.id @user.id.to_s
end

json.authorization_token @user.api_key.token