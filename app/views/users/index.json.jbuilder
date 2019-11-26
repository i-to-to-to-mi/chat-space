json.array! @users do |user|
  json.id user.id
  json.email  user.email
  # json.password  user.encrypted_password
  json.name  user.name
end