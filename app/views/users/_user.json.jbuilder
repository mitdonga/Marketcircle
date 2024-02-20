json.extract! user, :id, :name, :created_at

if user.info.present?
  json.info user.info, :id, :title, :email, :age, :phone
end
