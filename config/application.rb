require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Base
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # unsafe-eval is needed for script-src due to bootstrap
    # There is an outstanding issue to hopefully make that unnecessary:
    # https://github.com/twbs/bootstrap/issues/17964
    csp_settings = [
      "connect-src 'self'",
      "default-src 'none'",
      "font-src 'self' http: https:",
      "img-src 'self' http: https:",
      "script-src 'self' 'unsafe-eval' http: https:",
      "style-src 'self' https://maxcdn.bootstrapcdn.com"
    ]
    config.action_dispatch.default_headers = {
      'Content-Security-Policy' => csp_settings.join(';')
    }
    path_to = '**/' # workaround for rubocop style warning for next line
    config.autoload_paths += Dir[Rails.root.join('lib', path_to)]
  end
end
