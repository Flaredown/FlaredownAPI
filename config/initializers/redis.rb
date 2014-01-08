db = Rails.env.test? ? 1 : 0
REDIS = Redis.new(host: "127.0.0.1", port: 6379, db: db)
Resque.redis = REDIS