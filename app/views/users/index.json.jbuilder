json.users do
  json.array! @users, partial: "users/user", as: :user
end
json.page @page.to_i
json.per_page @per_page.to_i
json.total_users @total_users
