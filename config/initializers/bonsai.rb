if Rails.env.production?
  client =  Elasticsearch::Client.new({url: ENV['BONSAI_URL'], logs: true})
  Elasticsearch::Model.client = client
  Elasticsearch::Persistence.client = client
end
