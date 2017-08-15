class AmazonProductImporter
  def self.import(asin)
    response = Amazon::Ecs.item_lookup(asin, { ResponseGroup: 'Small, Reviews' })
    raise AmazonImporterError.new, response.error if response.has_error?
    item = response.get_element("Item")
    reviews_url = item.get_element('CustomerReviews').get_unescaped('IFrameURL')
    product_name = item.get_element('ItemAttributes').get('Title')
    scraper = ::AmazonProductScraper.new(reviews_url, { name: product_name })
    begin
      product = Product.find(asin)
      product.update_attributes(scraper.product_attributes)
    rescue Elasticsearch::Persistence::Repository::DocumentNotFound
      Product.create(scraper.product_attributes)
    end
  end
end
