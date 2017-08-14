class ProductUpdater
  include Sidekiq::Worker

  def perform
    Product.all.each do |product|
      response = Amazon::Ecs.item_lookup(product.id, { ResponseGroup: 'Small, Reviews' })
      item = response.get_element("Item")
      product.name = item.get_element('ItemAttributes').get('Title')
      product.reviews_url = item.get_element('CustomerReviews').get('IFrameURL')
      product.save
    end
  end
end
