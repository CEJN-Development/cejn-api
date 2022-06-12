module ObjectCreators
  # CONVENIENCE methods

  def create_user(params = {})
    user = User.new(
      email: params[:email].presence || 'testemail@gmail.com',
      full_name: Faker::Name.name,
      password: 'password!1I',
      password_confirmation: 'password!1I'
    )
    user.skip_confirmation!
    user.save!
    user
  end

  def get_browser
    'Chrome||89'
  end

  def get_os
    'Linux||5.0'
  end

  def get_aud
    Digest::SHA256.hexdigest("#{get_os}||||#{get_browser}")
  end

  def get_jwt_cookie(login)
    headers = { 'HTTP_JWT_AUD': get_aud }
    post '/login', params: {
      user: { email: login, password: 'password!1I' },
      browser: get_browser,
      os: get_os
    }, headers: headers
    response.cookies['jwt']
  end

  def headers_with_http_cookie(jwt)
    {
      "Accept": 'application/json',
      "Content-Type": 'application/json',
      'HTTP_JWT_AUD': get_aud,
      'Authorization': "Bearer #{jwt}"
    }
  end

  def create_allowlisted_jwts(params = {})
    user = params[:user].presence || create(:user)
    user.allowlisted_jwts.create!(
      jti: params['jti'].presence || 'TEST',
      aud: params['aud'].presence || 'TEST',
      exp: Time.at(params['exp'].presence.to_i || Time.now.to_i)
    )
  end

  def sign_user_in(user = {})
    authenticated_user = user.presence || create_user
    user_jwt = get_jwt_cookie(authenticated_user.email)
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    my_cookies[:jwt] = user_jwt
    cookies[:jwt] = my_cookies[:jwt]
    headers_with_http_cookie(user_jwt)
  end
end

RSpec.configure do |config|
  config.include ObjectCreators
end
