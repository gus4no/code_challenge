class Product
  include Elasticsearch::Persistence::Model
  attribute :name, String
  attribute :rating, Object
  attribute :total_reviews, Integer
  attribute :reviews, Array
end
