class HomeController < ApplicationController

  layout 'index'

  def index
  end

  def test
    uri = URI.parse(@api_url + "/cardholder/root")

    # 2 options to calling API with oauth access token, setting as Bearer in Header, or just as form parameter
    @result = http_get(uri).body

    render action: 'index'
  end

  def test_card_balance
    uri = URI.parse(@api_url + "/cardholder/balance")

    # 2 options to calling API with oauth access token, setting as Bearer in Header, or just as form parameter
    card_number_param = { 'cardnumber' => 'xxx' }
    @result = http_get(uri, card_number_param).body

    render action: 'index'
  end

  def test_gift_fund

    uri = URI.parse(@api_url + "/transaction/gift/credit")

    # 2 options to calling API with oauth access token, setting as Bearer in Header, or just as form parameter
    post_params = { 'device_id' => session[:device_id], 'cardnumber' => 'X', 'amount' => '50.0' }
    @result = http_post(uri, post_params).body

    render action: 'index'
  end

end
