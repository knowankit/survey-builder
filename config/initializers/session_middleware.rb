require 'rack/session/cookie'

Rails.application.config.middleware.use Rack::Session::Cookie, {
  key: '_survey_builder_app_session',
  secret: File.read('.session.key'),
  same_site: :lax,
  expire_after: 1.day
}
