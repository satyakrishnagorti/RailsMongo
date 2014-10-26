json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :rest_id, :name, :location, :loc_id, :zone_id, :city_name, :city_id, :cuisines, :cost_for_two, :rating
  json.url restaurant_url(restaurant, format: :json)
end
