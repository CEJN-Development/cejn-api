class DeviseCustomFailure < Devise::FailureApp
  def respond
    # If fails on certain actions, then ignore and make request as if no user.
    # Basically, any with `authenticate_user_if_needed!` needs to use this as a fallback
    path_params = request.path_parameters
    control = path_params[:controller]
    act = path_params[:action]
    if controll == 'api/v1/ping' && act == 'index'
      classify = control.classify.pluralize

      warden_options[:recall] = "#{classify}##{act}"
      request_headers['auth_failure'] = true
      request_headers['auth_failure_message'] = i18n_message
      recall
    else
      http_auth
    end
  end

  def http_auth_body
    {
      authFailure: true,
      error: i18n_message
    }.to_json
  end
end
