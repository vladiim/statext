class Account < Sequel::Model

  def self.find_by_id(id)
    find(id: id)
  end

  def self.find_or_create_with_omniauth(auth)
    email = auth.fetch(:info).fetch(:email)
    Account.find(email: email) || create_with_omniauth(auth)
  end

  def google_data
    return refresh_token! if token_expired?
    google_auth_data
  end

  def refresh_token!
    TokenRefresher.new(self).refresh!
  end

  def update_token!(token)
    update(google_auth_data: updated_google_auth_data(token).to_json)
  end

  private

  def updated_google_auth_data(token)
    JSON.parse(google_auth_data).tap do |data|
      data['credentials']['access_token'] = token.fetch('access_token')
      data['credentials']['expires_at']   = Time.new.to_i + token.fetch('expires_in')
    end
  end

  def token_expired?
    JSON.parse(google_auth_data)
      .fetch('credentials')
      .fetch('expires_at')
      .to_i < Time.new.to_i
  end

  def self.create_with_omniauth(auth)
    create(
      first_name: auth.fetch(:info).fetch(:first_name),
      last_name:  auth.fetch(:info).fetch(:last_name),
      email:      auth.fetch(:info).fetch(:email),
      role:       'user',
      google_auth_data: auth.to_json
    )
  end
end
