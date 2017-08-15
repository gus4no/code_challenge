import $ from 'jquery';
import React from 'react';
import PropTypes from 'prop-types';

export default class Product extends React.Component {
  renderReviews(){
    return this.props.product.reviews.map((review, index) =>
      <div key={index}>
        <img src={review.rating.img} />
        <span>({review.rating.text})</span>
        <p>By: <b>{review.reviewer}</b></p>
        <p>{review.text}</p>
      </div>
    )
  }

  render(){
    return(
      <div className="col-xs-12">
        <div className="product-details">
          <h2>{this.props.product.name}</h2>
          <div>
            <img src={this.props.product.rating.img} />
            <span>({this.props.product.rating.text}) / {this.props.product.total_reviews} Total reviews</span>
          </div>
          <div className="product-reviews">
            <h4>Customer reviews</h4>
            {this.renderReviews()}
          </div>
        </div>
      </div>
    );
  }
}

Product.PropTypes = {
  product: React.PropTypes.object
}
