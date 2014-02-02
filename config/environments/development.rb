ApiClient::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.dev_url = 'https://developer.ackroo.com'
  config.api_url = 'https://api.ackroo.net'
  config.oauth_provider = 'https://manage.ackroo.com'

  # Set the Ackroo Developer application id, secret, and redirect_uri. All 3 should match the application you created in developer portal
  # Otherwise, you will get an authorization failure
  config.client_id = ''
  config.client_secret = ''
  # This is your Rails server hostname running this application. Typically localhost running on port 3000 for development testing
  # This would need to change to external hostname of your Rails application once it goes production/live
  config.redirect_uri = 'http://localhost:3000'

  # A Space deliimited string of scopes. Check API guide for more info
  # e.g. 'card transaction'. Set to only cardholder scope at the moment
  config.oauth_scopes = 'card'
end
