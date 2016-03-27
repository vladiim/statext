class Account < Sequel::Model
  USER_ROLE    = 'user'
  CREDENTIALS  = 'credentials'
  TOKEN        = 'token'
  EXPIRES_AT   = 'expires_at'
  EXPIRES_IN   = 'expires_in'
  ACCESS_TOKEN = 'access_token'

  def self.find_by_id(id)
    find(id: id)
  end

  def self.find_or_create_with_omniauth(auth)
    email = auth.fetch(:info).fetch(:email)
    Account.find(email: email) || create_with_omniauth(auth)
  end

  def google_data
    refresh_token! if token_expired?
    google_auth_data
  end

  def authorised_token
    refresh_token! if token_expired?
    token
  end

  def update_token!(token)
    update(google_auth_data: updated_google_auth_data(token).to_json)
  end

  def update_reports!(reports)
    update(reports: reports.to_json)
  end

  def all_reports
    Report.new(self).generate
  end

  private

  def updated_google_auth_data(token)
    JSON.parse(google_auth_data).tap do |data|
      data[CREDENTIALS][ACCESS_TOKEN] = token.fetch(ACCESS_TOKEN)
      data[CREDENTIALS][EXPIRES_AT]   = Time.new.to_i + token.fetch(EXPIRES_IN)
    end
  end

  def self.create_with_omniauth(auth)
    create(
      first_name: auth.fetch(:info).fetch(:first_name),
      last_name:  auth.fetch(:info).fetch(:last_name),
      email:      auth.fetch(:info).fetch(:email),
      role:       USER_ROLE,
      google_auth_data: auth.to_json
    )
  end

  def refresh_token!
    TokenRefresher.new(self).refresh!
  end

  def credentials
    JSON.parse(google_auth_data)
      .fetch(CREDENTIALS)
  end

  def token
    credentials.fetch(TOKEN)
  end

  def expires_at
    credentials.fetch(EXPIRES_AT)
  end

  def token_expired?
    expires_at.to_i < Time.new.to_i
  end
end
