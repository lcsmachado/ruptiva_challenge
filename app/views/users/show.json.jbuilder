json.user do
  json.call(@user, :id, :first_name, :last_name, :email, :role)
end
