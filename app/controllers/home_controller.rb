class HomeController < ApplicationController

  layout 'index'

  def index
  end

  def test
    uri = URI.parse(@api_url + "/cardholder/root")

    # 2 options to calling API with oauth access token, setting as Bearer in Header, or just as form parameter
    @result = http_get_using_headers(uri).body
    #@result = http_get_using_params(uri).body

    render action: 'index'
  end

  def test_card_balance
    uri = URI.parse(@api_url + "/cardholder/balance")

    # 2 options to calling API with oauth access token, setting as Bearer in Header, or just as form parameter
    card_number_param = { 'cardnumber' => 'xxx' }
    @result = http_get_using_headers(uri, card_number_param).body
    #@result = http_get_using_params(uri, card_number_param).body

    render action: 'index'
  end

  def http_get_using_headers(uri, params = {})
    headers = { 'Authorization' => "Bearer #{session[:oauth_access_token]}" }
    request = Net::HTTP::Get.new(uri.path, headers)
    request.set_form_data( params) unless params.blank?
    http_client = http_client_ssl(uri)
    @result = http_client.request(request)
  end

  def http_get_using_params(uri, params = {})
    request = Net::HTTP::Get.new(uri.path)
    access_token_param = { 'access_token' => session[:oauth_access_token] }
    params = params.merge(access_token_param)
    request.set_form_data( params) unless params.blank?
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

  def http_client(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    return http
  end
end
