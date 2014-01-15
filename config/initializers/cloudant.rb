if ENV['CLOUDANT_URL'] and uri = URI.parse(ENV['CLOUDANT_URL'])
  CouchRest::Model::Base.configure do |config|
    config.connection = {
      :protocol => uri.scheme,
      :host     => uri.host,
      :port     => uri.port,
      :prefix   => 'cdai', # database name or prefix
      :suffix   => nil,
      :join     => '_',
      :username => uri.user,
      :password => uri.password
    }
  end
end