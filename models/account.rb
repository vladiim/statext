class Account < Sequel::Model

  def self.find_by_id(id)
    find(id: id)
  end

  def self.find_or_create_with_omniauth(auth)
    email = auth.fetch(:info).fetch(:email)
    Account.find(email: email) || create_with_omniauth(auth)
  end

  private

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
