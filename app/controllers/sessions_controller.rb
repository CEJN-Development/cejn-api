class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    # @user = User.find_by(email: sessions_params[:email])
    # if @user&.valid_password?(sessions_params[:password])
    #   render json: @user, status: :created
    # else
    #   head(:unauthorized)
    # end

    # Doing this to handle rspec weirdness
    possible_aud = request.headers['HTTP_JWT_AUD'].presence || request.headers['JWT_AUD'].presence
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    if user_signed_in?
      # TODO: resource.blocked?
      #
      # For the initial login, we need to manually update IP / metadata for jWT here as no hooks
      # And we'll want this data for all subsequent requests
      last = resource.allowlisted_jwts.where(aud: possible_aud).last
      aud = possible_aud || 'UNKNOWN'
      if last.present?
        last.update_columns({
          browser_data: params[:browser],
          os_data: params[:os_data],
          remote_ip: params[:ip]
        })
        aud = last.aud
      end
      respond_with(resource, { aud: aud })
    else
      render json: resource.errors, status: 401
    end
  rescue => e
    render json: { error: 'Unexpected error' }, status: 500
  end

  # def end
  #   if authenticate_user.present?
  #     authenticate_user.first['user_id']
  #     render json: { message: 'Logout successful' }, status: :ok
  #   else
  #     head(:unauthorized)
  #   end
  # end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end

  # What we respond with for signing in
  # Add token in with body as fetch+CORS cannot read Authorization header
  def respond_with(resource, opts = {})
    # NOTE: the current_token _showld_ be the last AllowlistedJwt, but it might not
    # be, in case of race conditions and such
    render json: {
      user: resource.for_display,
      jwt: current_token,
      aud: opts[:aud]
    }
  end

  def respond_to_on_destroy
    render json: { message: 'Session signed out' }
  end

  def sessions_params
    params.permit(:email, :password)
  end
end
