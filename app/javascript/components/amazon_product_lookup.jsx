import $ from 'jquery';
import React from 'react';
import PropTypes from 'prop-types';
import Product from './product';

export default class AmazonProductLookup extends React.Component {
  constructor(){
    super();
    this.state = {
      asin: '',
      product: null,
      error: null
    }
  }

  handleChange(event){
    this.setState({ asin: event.target.value });
  }

  getProduct(){
    let url = `api/v1/products/${this.state.asin}`
    $.ajax({
      url: url,
      dataType: 'json',
      type: 'POST',
      success: function(data) {
        this.setState({product: data, error: null});
      }.bind(this),
      error: function(data) {
        this.setState({ error: data.responseJSON.error });
      }.bind(this)
    });
  }

  render(){
    let product;
    if(this.state.product){
      product = <Product product={this.state.product} />
    }

    return (
      <div className="container amazon-product-lookup">
        <div className="form-inline search-form">
          <div className="form-group">
            <input className="form-control" onChange={this.handleChange.bind(this)} />
          </div>
          <div className="form-group">
            <input className="btn btn-primary" type="button" value="Find product" onClick={this.getProduct.bind(this)} />
          </div>
        </div>
        <p className="error">
          {this.state.error}
        </p>
        <div>
          {product}
        </div>
      </div>);
  }
}
