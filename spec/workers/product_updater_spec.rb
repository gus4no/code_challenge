require 'rails_helper'

describe ProductUpdater do
  describe '#perform' do
    let(:product) { Product.create(id: 'B002QYW8LW') }
    before do
      expect(Product).to receive(:all).and_return [product]
    end

    it 'updates product information from amazon' do
      VCR.use_cassette('amazon_lookup') do
        VCR.use_cassette('amazon_reviews') do
          job = ProductUpdater.new
          expect(product.total_reviews).to be nil
          job.perform
          expect(Product.find('B002QYW8LW').total_reviews).to eq 6024
        end
      end
    end
  end
end
