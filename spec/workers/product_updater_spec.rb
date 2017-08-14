require 'rails_helper'

describe ProductUpdater do
  describe '#perform' do
    before do
      product = Product.new(id: 'B002QYW8LW')
      expect(Product).to receive(:all).and_return [product]
    end

    it 'updates product information from amazon' do
      VCR.use_cassette('amazon_lookup') do
        job = ProductUpdater.new
        job.perform
        product = Product.find('B002QYW8LW')
        expect(product.name).to eq 'Baby Banana Infant Training Toothbrush and Teether, Yellow'
        expect(product.reviews_url).to eq 'https://www.amazon.com/reviews/iframe?akid=AKIAJLF4KCDNSCNVJ25A&amp;alinkCode=xm2&amp;asin=B002QYW8LW&amp;atag=jscc0a-20&amp;exp=2017-08-15T05%3A48%3A22Z&amp;v=2&amp;sig=39uP84vSB7dY1zkcp7mwBTQKKxpxE7oEPxNoIAwYGPk%253D'
      end
    end
  end
end
