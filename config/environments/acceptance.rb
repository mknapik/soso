# Acceptance builds on production's configuration.
require Rails.root.join('config/environments/production')

Soso::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb and config/production.rb.

  # When deploying to Heroku, the app must serve static assets (or serve them from a CDN).
  config.serve_static_assets = true

  config.action_mailer.default_url_options = {host: 'soso3.herokuapp.com'}
end
