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


  def http_get(uri, params = {})
    headers = { 'Authorization' => "Bearer #{session[:oauth_access_token]}" }
    request = Net::HTTP::Get.new(uri.path, headers)
    request.set_form_data( params) unless params.blank?
    http_client = http_client_ssl(uri)
    @result = http_client.request(request)
  end

  def http_post(uri, params = {})
    headers = {'Authorization' => "Bearer #{session[:oauth_access_token]}"}
    request = Net::HTTP::Post.new( uri.path , headers)
    request.set_form_data(params) unless params.blank?
    http_client = http_client_ssl(uri)
    @result = http_client.request(request)
  end

  def http_client_ssl(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.ca_file = ENV['SSL_CERT_FILE']
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    return http
  end

end
