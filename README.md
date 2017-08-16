# Amazon Product Lookup

Amazon product lookup is a simple app to get amazon product's rating and reviews.

# Development

This app uses Rails 5.1 and Webpack.

Make sure you have the following tools installed.

- yarn: `brew install yarn`
- elasticsearch: `brew install elasticsearch`

1.- Clone the repo and run `bundle install`

2.- Run `foreman start -f Procfile.dev`

3.- Run `./bin/webpack-dev-server` in project root.

4.- Go to `http://localhost:5000` and you're all set


# Test

Simply run `bundle exec rspec spec/`, this would boot up an elasticsearch cluster in port `9250` to run tests against.
