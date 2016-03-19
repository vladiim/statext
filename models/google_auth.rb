require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'googleauth/stores/redis_token_store'

class GoogleAuth
  CLIENT_SECRETS = 'config/client_secrets.json'
  ANALYTICS_READ = 'https://www.googleapis.com/auth/analytics.readonly'
  CALLBACK_URL   = '/auth/callback'

  def self.get_authorization_url(email, request)
    authorizer.get_authorization_url(login_hint: email, request: request)
  end

  def self.handle_auth_callback_deferred(request)
    web_authorizer.handle_auth_callback_deferred(request)
  end

  private
  def self.authorizer
    client_id   = Google::Auth::ClientId.from_file(CLIENT_SECRETS)
    scope       = [ANALYTICS_READ]
    token_store = Google::Auth::Stores::RedisTokenStore.new(redis: Redis.new)
    authorizer  = web_authorizer.new(
      client_id, scope, token_store, CALLBACK_URL)
  end

  def self.web_authorizer
    Google::Auth::WebUserAuthorizer
  end
end
