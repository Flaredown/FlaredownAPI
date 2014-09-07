db = Rails.env.test? ? 1 : 0
REDIS = Redis.new(host: "127.0.0.1", port: ENV["REDIS_PORT"], db: db)
Resque.redis = REDIS