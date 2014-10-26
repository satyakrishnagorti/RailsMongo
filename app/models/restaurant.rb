class Restaurant
  include Mongoid::Document
  field :rest_id, type: String
  field :name, type: String
  field :location, type: String
  field :loc_id, type: String
  field :zone_id, type: String
  field :city_name, type: String
  field :city_id, type: String
  field :cuisines, type: String
  field :cost_for_two, type: String
  field :rating, type: String
end
