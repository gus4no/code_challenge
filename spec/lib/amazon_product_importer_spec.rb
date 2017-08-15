require 'rails_helper'

describe AmazonProductImporter do
  describe 'self.import' do
    context 'when product already exists' do
      let(:product) { Product.create(id: 'B002QYW8LW') }
      before do
        allow(Product).to receive(:find).and_return product
      end

      it 'responds with updates the product' do
        VCR.use_cassette('amazon_lookup') do
          VCR.use_cassette('amazon_reviews') do
            expect(product).to receive(:update_attributes)
            AmazonProductImporter.import('B002QYW8LW')
          end
        end
      end

    end

    context 'when product doesnt exist' do
      before do
        allow(Product).to receive(:find).and_raise(Elasticsearch::Persistence::Repository::DocumentNotFound)
      end

      it 'responds with updates the product' do
        VCR.use_cassette('amazon_lookup') do
          VCR.use_cassette('amazon_reviews') do
            expect(Product).to receive(:create)
            AmazonProductImporter.import('B002QYW8LW')
          end
        end
      end

    end

    context 'when invalid asin' do
      it 'raises AmazonImporterError' do
        VCR.use_cassette('fake_product') do
          expect{AmazonProductImporter.import('fake_product')}.to raise_error(AmazonImporterError)
        end
      end
    end
  end
end
