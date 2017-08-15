class ProductUpdater
  include Sidekiq::Worker

  def perform
    Product.all.each do |product|
      AmazonProductImporter.import(product.id)
    end
  end
end
