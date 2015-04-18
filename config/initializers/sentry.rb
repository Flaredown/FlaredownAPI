require 'raven'

Raven.configure do |config|
  config.dsn = 'https://abc33c1c41d4408fa51678e76e3143b3:4e0dfc5161024e77b7f43226e1bb7a22@app.getsentry.com/42020'
  config.environments = %w(production staging)
  config.tags = { environment: Rails.env }
end