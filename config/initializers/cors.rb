# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  origins = if Rails.env.development?
              [ENV['CEJN_CLIENT_URL'],
               "#{ENV['ACTION_MAILER_HOST']}/#{ENV['ACTION_MAILER_PORT']}"].freeze
            else
              [ENV['CEJN_CLIENT_URL']].freeze
            end

  allow do
    origins origins
    resource  '*',
              headers: :any,
              credentials: true,
              methods: %i[get post put patch delete options head].freeze
  end
end
