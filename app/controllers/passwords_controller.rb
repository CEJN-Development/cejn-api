class PasswordsController < Devise::PasswordsController
  respond_to :json

  def create
    if params[:user] && params[:user][:email].blank?
      render json: { error: 'Invalid Password' }, status: 406
    else
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      if successfully_sent?(resource)
        render json: { message: 'Password reset instructions sent.' }
      else
        respond_with_error(resource)
      end
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.none?
      if Devise.sign_in_after_reset_password
        resource.after_database_authentication
        sign_in(resource_params, resource)
        if user_signed_in?
          respond_with(resouce)
        else
          respond_with_error(resource)
        end
      else
        respond_with(resource)
      end
    else
      set_minimum_password_length
      respond_with_error(resource)
    end
  end

  private

  def current_token
    # NOTE: this is technically nil at this point, and user still must login again
    request.env['warden-jwt_auth.token']
  end

  def response_json(resource)
    json = {
      message: 'Authentication success',
      user: resource.for_display
    }
    json.merge(jwt: current_token) if reveal_aud?
  end

  def respond_with(resource, _opts = {})
    render json: response_json(resource)
  end

  def respond_with_error(resource)
    render json: resource.errors, status: 401
  end

  def reveal_aud?
    request.headers['x-HOST_ID'].present?
  end
end
