class AmazonProductScraper
  attr_accessor :html, :initial_attrs

  def initialize(url, initial_attrs = {})
    @html = Nokogiri::HTML(open(url))
    @initial_attrs = initial_attrs
  end

  def product_attributes
    @initial_attrs.merge(rating_and_reviews)
  end

  private

  def rating_and_reviews
    {
      total_reviews: total_reviews,
      rating: build_rating_node,
      reviews: build_reviews_node
    }
  end

  def total_reviews
    html.css('.crIFrameHeaderHistogram > div > b').text.split[0].gsub(',','').to_i
  end

  def build_rating_node
    rating = html.css('.asinReviewsSummary img')
    { text: rating.attribute('alt').text, img: rating.attribute('src').text }
  end

  def build_reviews_node
    reviews = html.css('table.crIFrameReviewList tr td > div')
    reviews.map do |review|
      review_rating_node = review.css('div > span > img')
      {
        text: review.css('.reviewText').text,
        reviewer: review.css('div:nth-child(3) a:first-child').text,
        rating: {
          text: review_rating_node.attribute('alt').text,
          img: review_rating_node.attribute('src').text,
        }
      }
    end
  end
end
