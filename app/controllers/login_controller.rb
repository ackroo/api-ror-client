class LoginController < ApplicationController
  layout 'index'

  def index
    # Clear out session if you wish to get rid of oauth token in session
    reset_session
    if (!session[:oauth_access_token].blank?)
      redirect_to(:controller => "home", :action => "index")
      return
    elsif (!params[:code].nil?)
      code = params[:code]
      begin
        $access_token = @oauth_client.auth_code.get_token(code, :redirect_uri => Rails.application.config.redirect_uri, :headers => {'Authorization' => 'Basic some_password'})
      rescue
        flash[:alert] = t(:error_invalid_pin)
        redirect_to(:action => "index")
        return
      end
      user_session($access_token.token)
      get_device(code)
      redirect_to(:controller => "home", :action => "index")
      return
    end
  end

  def login
    authorize_url = setup_oauth_auth_url
    redirect_to authorize_url
    return
  end

  def user_session(token)
    reset_session
    session[:oauth_access_token] = token
  end

  def get_device(code)
    uri = URI.parse(@api_url + "/device")
    @result = http_get(uri, { :code => code })
    parsed_result = JSON.parse(@result.body)
    session[:device_id] = parsed_result["device"]
  end

  def setup_oauth_auth_url
    extra_params = { :redirect_uri => Rails.application.config.redirect_uri, :scope => Rails.application.config.oauth_scopes }
    authorize_params = @oauth_client.auth_code.authorize_params
    authorize_params = authorize_params.merge(extra_params)

    query = extra_params.dup.to_query
    authorize_url = "#{@oauth_client.auth_code.authorize_url}&#{query}"
    return authorize_url
  end

end
