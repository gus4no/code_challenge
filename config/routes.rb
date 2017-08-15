Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  namespace :api, constraints: lambda { |req| req.format == :json }do
    namespace :v1 do
      post 'products/:asin', to: 'products#import', as: :products_import
    end
  end
end
