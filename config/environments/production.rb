require Rails.root.join("config/mailer")
Rails.application.configure do
    # Verifies that versions and hashed value of the package contents in the project's package.json
  config.webpacker.check_yarn_integrity = false

  config.paperclip_defaults = {
    storage: :s3,
    s3_protocol: 'https'
    s3_region: ENV.fetch('AWS_REGION', 'us-east-1'),
    s3_credentials: {
      bucket: ENV['S3_BUCKET']
    }
  }
  config.force_ssl = true
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.read_encrypted_secrets = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.log_level = :debug
  config.log_tags = [:request_id]
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end
  config.active_record.dump_schema_after_migration = false
end
Rack::Timeout.timeout = (ENV["RACK_TIMEOUT"] || 10).to_i