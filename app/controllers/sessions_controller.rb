class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    # Doing this to handle rspec weirdness
    possible_aud = request.headers['HTTP_JWT_AUD'].presence || request.headers['JWT_AUD'].presence
    if params[:browser].present?
      browser, version = params[:browser].split('||')
      digest = Digest::SHA256.hexdigest("#{params[:os]}||||#{browser}||#{version.to_i}")
      raise 'Unmatched AUD' if digest != possible_aud
    end
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    if user_signed_in?
      # TODO: resource.blocked?
      #
      # For the initial login, we need to manually update IP / metadata for jWT here as no hooks
      # And we'll want this data for all subsequent requests
      last = resource.allowlisted_jwts.where(aud: possible_aud).last
      aud = possible_aud
      if last.present?
        last.update_columns({
                              browser_data: params[:browser],
                              os_data: params[:os],
                              remote_ip: params[:ip]
                            })
        aud = last.aud
      end
      respond_with(resource, { aud: aud })
    else
      render json: resource.errors, status: 401
    end
  rescue StandardError => e
    render json: { error: 'Unexpected error' }, status: 500
  end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end

  # What we respond with for signing in
  # Add token in with body as fetch+CORS cannot read Authorization header
  def respond_with(resource, opts = {})
    # NOTE: the current_token _showld_ be the last AllowlistedJwt, but it might not
    # be, in case of race conditions and such
    render json: response_json(resource, opts)
  end

  def respond_to_on_destroy
    render json: { message: I18n.t('controllers.sessions.sign_out') }
  end

  def response_json(resource, opts = {})
    response = { user: resource.for_display }
    response.merge!(aud: opts[:aud], jwt: current_token) if reveal_aud?
    response.as_json
  end

  def reveal_aud?
    request.headers['x-HOST_ID'].present?
  end
end
