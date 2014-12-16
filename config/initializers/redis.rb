db = Rails.env.test? ? 1 : 0

if ENV["REDISCLOUD_URL"]
  REDIS = Redis.new(:url => ENV["REDISCLOUD_URL"])
else
  REDIS = Redis.new(host: "127.0.0.1", port: ENV["REDIS_PORT"], db: db)
end

Resque.redis = REDIS