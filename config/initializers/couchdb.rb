if ENV['COUCH_USER'] and ENV['COUCH_PASS']

    CouchRest::Model::Base.configure do |config|
      config.connection = {
        protocol: "https",
        host:     ENV['COUCH_URL'],
        port:     443,
        prefix:   ENV['COUCH_DB_NAME'],
        suffix:   nil,
        join:     '_',
        username: ENV['COUCH_USER'],
        password: ENV['COUCH_PASS']
      }
    end
else

  CouchRest::Model::Base.configure do |config|
    config.connection = {
      protocol: "http",
      host:     "localhost",
      port:     5984,
      prefix:   "flaredown-#{Rails.env}",
      suffix:   nil,
      join:     '_',
    }
  end

end