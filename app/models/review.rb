class Review
  include Mongoid::Document
  field :rest_id, type: String
  field :user, type: String
  field :review_text, type: String
  field :rating, type: String
end
