class ReviewCount
  include Mongoid::Document
  field :rest_id, type: String
  field :rev_count, type: String
end
