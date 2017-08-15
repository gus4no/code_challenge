class Api::V1::ProductsController < ApplicationController
  rescue_from AmazonImporterError, with: :render_error_response

  def import
    product = begin
      Product.find(params[:asin])
    rescue Elasticsearch::Persistence::Repository::DocumentNotFound
      AmazonProductImporter.import(params[:asin])
    end

    render json: product
  end
end
