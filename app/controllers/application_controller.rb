class ApplicationController < ActionController::Base
  protect_from_forgery

  require 'oauth2'

  protected

  before_filter :setup

  def setup
    @oauth_client = ApiClient::Application.config.oauth_client
    @api_url = Rails.application.config.api_url
  end

  # Use this method to optionally refresh token using oauth client if it is set to expire or get unauthorized access from Ackroo API
  def refresh_token
    if (!$access_token.nil? && $access_token.expired?)
      begin
        $access_token = $access_token.refresh!
        session[:oauth_access_token] = $access_token.token
      rescue
        return
      end

    end
  end

  def unauthorized?(result)
    if result.code.eql?('401')
      redirect_to(:controller => "login", :action => "index")
      return true
    end
    return false
  end

end
