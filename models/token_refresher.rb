class TokenRefresher
  REFRESH_TOKEN_URL = 'https://accounts.google.com/o/oauth2/token'
  attr_reader :account
  def initialize(account)
    @account = account
  end

  def refresh!
    response = HTTParty.post(REFRESH_TOKEN_URL, options)
    account.update_token!(response.parsed_response)
  end

  def options
    options = {
      body: options_body,
      headers: options_headers}
  end

  private

  def options_body
    {
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      refresh_token: refresh_token,
      grant_type: 'refresh_token'
    }
  end

  def options_headers
    {'Content-Type' => 'application/x-www-form-urlencoded'}
  end

  def refresh_token
    JSON.parse(account.google_auth_data)
      .fetch('credentials')
      .fetch('refresh_token')
  end
end
