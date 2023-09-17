Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/0' } # Use the service name defined in docker-compose.yml
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0' } # Use the service name defined in docker-compose.yml
end
