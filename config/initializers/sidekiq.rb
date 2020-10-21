require 'sidekiq/web'
Sidekiq::Web.class_eval do
  use Rack::Protection, :except => :http_origin
end

Sidekiq::Web.set :sessions, false
Sidekiq::Web.set :session_secret, Rails.application.credentials[:secret_key_base]
Sidekiq::Extensions.enable_delay!

credentials = Rails.application.credentials[Rails.env.to_sym]
cache_address = "redis://#{credentials[:redis_host]}:#{credentials[:redis_port]}/0/sidekiq"

Sidekiq.configure_server do |config|
  config.redis = { url: cache_address }
  
  schedule_file = "config/schedule.yml"
  if File.exist?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: cache_address }
end