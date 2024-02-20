json.users do
  json.array! @users, partial: "users/user", as: :user
end
json.page @page
json.per_page @per_page
json.total_users @total_users
