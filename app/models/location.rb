class Location
  include Mongoid::Document
  field :loc_id, type: String
  field :loc_name, type: String
  field :zone_id, type: String
end
