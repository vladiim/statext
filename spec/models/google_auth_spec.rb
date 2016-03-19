require 'spec_helper'

RSpec.describe GoogleAuth do
  let(:email) {'email'}
  let(:request) {'request'}
  let(:web_auth) {Google::Auth::WebUserAuthorizer}

  describe '.get_authorization_url(email, request)' do
    it 'returns an url' do
      expect_any_instance_of(web_auth).to receive(:get_authorization_url).and_return('URL')
      expect(GoogleAuth.get_authorization_url(email, request)).to eq('URL')
    end
  end

  describe '.handle_auth_callback_deferred(request)' do
    it 'returns an url' do
      expect(Google::Auth::WebUserAuthorizer).to receive(:handle_auth_callback_deferred).and_return('URL')
      expect(GoogleAuth.handle_auth_callback_deferred(request)).to eq('URL')
    end
  end

  describe '.get_credentials(request)' do
    let(:request) {OpenStruct.new(session: {'email' => email})}
    it 'returns the credentials' do
      expect_any_instance_of(web_auth).to receive(:get_credentials).and_return('CREDENTIALS')
      expect(GoogleAuth.get_credentials(request)).to eq('CREDENTIALS')
    end
  end
end
