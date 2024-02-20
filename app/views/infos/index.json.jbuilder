json.infos do
  json.array! @infos, partial: "infos/info", as: :info
end
json.page @page
json.per_page @per_page
json.total_infos @total_infos