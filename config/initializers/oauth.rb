ApiClient::Application.config.oauth_client = OAuth2::Client.new(Rails.application.config.client_id, Rails.application.config.client_secret, :site => Rails.application.config.oauth_provider)
