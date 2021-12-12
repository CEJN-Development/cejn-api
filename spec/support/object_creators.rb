module ObjectCreators
  def create_allowlisted_jwts(params = {})
    user = params[:user].presence || create(:user)
    user.allowlisted_jwts.create!(
      jti: params['jti'].presence || 'TEST',
      aud: params['aud'].presence || 'TEST',
      exp: Time.at(params['exp'].presence.to_i || Time.now.to_i)
    )
  end

  # CONVENIENCE methods
  def get_headers(login)
    jwt = get_jwt(login)
    {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'HTTP_JWT_AUD': 'test',
      'Authorization': "Bearer #{jwt}"
    }
  end

  def get_headers_http_cookie(login)
    jwt = get_jwt_cookie(login)
    {
      "Accept": "application/json",
      "Content-Type": "application/json",
      'HTTP_JWT_AUD': 'test',
      'Authorization': "Bearer #{jwt}"
    }
  end

  def get_jwt(login)
    headers = { 'HTTP_JWT_AUD': 'test', 'x-HOST_ID': '1' }
    post '/login', params: { user: { email: login, password: 'password' } }, headers: headers
    JSON.parse(response.body, object_class: OpenStruct).jwt
  end

  def get_jwt_cookie(login)
    headers = { 'HTTP_JWT_AUD': 'test' }
    post '/login', params: { user: { email: login, password: 'password' } }, headers: headers
    response.cookies['jwt']
  end
end

RSpec.configure do |config|
  config.include ObjectCreators
end
