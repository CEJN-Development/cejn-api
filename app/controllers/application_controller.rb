class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  def errors_json(record)
    errors = { messages: [] }
    record.errors.each do |error|
      errors[:messages] << error.message
      errors[error.attribute] = [] unless errors.key? error.attribute
      errors[error.attribute].push error.type
    end
    errors.to_json
  end

  protected

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:login, keys: [:email])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
