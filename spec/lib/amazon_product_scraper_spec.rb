require 'rails_helper'

describe AmazonProductScraper do
  describe '#product_attributes' do
    it 'builds product attributes' do
      VCR.use_cassette('amazon_lookup') do
        url = 'https://www.amazon.com/reviews/iframe?akid=AKIAJLF4KCDNSCNVJ25A&alinkCode=xm2&asin=B002QYW8LW&atag=jscc0a-20&exp=2017-08-15T23%3A29%3A24Z&v=2&sig=CPd%252BSMiStI2O4UAR0N%252BTWAT6b2NKiTv9C2y5r%252FXjQRE%253D'
        scraper = AmazonProductScraper.new(url, name: 'Foo bar')
        product_attributes = scraper.product_attributes
        expect(product_attributes[:name]).to eq 'Foo bar'
        expect(product_attributes[:rating][:text]).to eq '4.7 out of 5 stars'
        expect(product_attributes[:rating][:img]).to eq 'https://images-na.ssl-images-amazon.com/images/G/01/x-locale/common/customer-reviews/ratings/stars-4-5._CB192238104_.gif'
        expect(product_attributes[:total_reviews]).to eq 6025
        expect(product_attributes[:reviews]).to be_kind_of Array
      end
    end
  end
end
