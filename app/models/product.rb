class Product
  include Elasticsearch::Persistence::Model
  attribute :name, String
  attribute :reviews_url, String
end
