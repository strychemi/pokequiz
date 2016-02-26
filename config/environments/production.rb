Rails.application.configure do

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_files = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.log_level = :debug
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false


  config.action_mailer.smtp_settings = {
      :address        => 'smtp.sendgrid.net',
      :port           => '587',
      :authentication => :plain,
      :user_name      => ENV['SENDGRID_USERNAME'],
      :password       => ENV['SENDGRID_PASSWORD'],
      :domain         => 'heroku.com',
      :enable_starttls_auto => true
  }
  config.action_mailer.delivery_method ||= :smtp

  # Rails also needs to know where your app is
  #   located to properly configure sending of emails
  config.action_mailer.default_url_options = {
      :host => 'morning-reaches-24747.herokuapp.com',
  }

  Paperclip.options[:command_path] = "/usr/local/bin/convert"
  config.paperclip_defaults = {

      # Don't forget to make S3 your storage option!
      :storage => :s3,

      :s3_credentials => {

          # put your host name here if needed
          #   see the reading below for more details
          # NOTE: This must be the correct region for YOU
          :url => "s3-us-west-2.amazonaws.com",
          :bucket => Rails.application.secrets.BUCKET,
          # NOTE: these lines are changed to use secrets.yml
          # from the examples (which use ENV vars instead)
          :access_key_id => Rails.application.secrets.AWS_KEY,
          :secret_access_key => Rails.application.secrets.AWS_PASS
      }
  }
end
