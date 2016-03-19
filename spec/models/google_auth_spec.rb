require 'spec_helper'

RSpec.describe GoogleAuth do
  describe '.get_authorization_url' do
    let(:email) {'email'}
    let(:request) {'request'}
    let(:web_auth) {Google::Auth::WebUserAuthorizer}
    it 'returns an url' do
      expect_any_instance_of(web_auth).to receive(:get_authorization_url).and_return('URL')
      expect(GoogleAuth.get_authorization_url(email, request)).to eq('URL')
    end
  end
end
