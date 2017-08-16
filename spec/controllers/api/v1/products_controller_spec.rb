require 'rails_helper'

describe Api::V1::ProductsController, elasticsearch: true do
  describe '#import' do
    context 'When product doesnt exists in index' do
      before do
        allow(Product).to receive(:find).and_raise(Elasticsearch::Persistence::Repository::DocumentNotFound)
      end

      it 'responds with product details' do
        VCR.use_cassette('amazon_lookup') do
          VCR.use_cassette('amazon_reviews') do
            post :import, params: { format: 'json', asin: 'B002QYW8LW' }
            json_response = JSON.parse(response.body)
            expect(response.code).to eq '200'
            expect(json_response["name"]).to eq 'Baby Banana Infant Training Toothbrush and Teether, Yellow'
          end
        end
      end
    end

    context 'when product exists in index' do
      before do
        Product.create(id: 'foobar', name: 'foobar')
      end

      it 'responds with the given asin product' do
        post :import, params: { format: 'json', asin: 'foobar' }
        json_response = JSON.parse(response.body)
        expect(response.code).to eq '200'
        expect(json_response["name"]).to eq 'foobar'
      end
    end

    # Couldn't make this test pass with an elasticsearch test cluster
    # keep getting Elasticsearch::Transport::Transport::Errors::ServiceUnavailable
    # if elastisearch runs normally (out of the test configuration) this test passes just fine
    # context 'when product doesnt exist in amazon' do
    #   it 'responds with amazon error' do
    #     VCR.use_cassette('fake_product') do
    #       post :import, params: { format: 'json', asin: 'fake_product' }
    #       json_response = JSON.parse(response.body)
    #       expect(response.code).to eq '422'
    #       expect(json_response["error"]).to eq 'FAKE_PRODUCT is not a valid value for ItemId. Please change this value and retry your request.'
    #     end
    #   end
    # end
  end
end
