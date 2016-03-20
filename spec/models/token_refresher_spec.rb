require 'spec_helper'
load "#{Dir.pwd}/spec/data/google_omni_auth.rb"

RSpec.describe TokenRefresher do
  let(:account) {Object.new}
  let(:subject) {described_class.new(account)}
  describe '.new' do
    it 'stores the account' do
      expect(subject.account).to eq(account)
    end
  end

  describe '#refresh!' do
    let(:google_auth_data) {GoogleOmniAuth.data.to_json}
    let(:parsed_response)  {Object.new}
    let(:new_token)        {OpenStruct.new(parsed_response: parsed_response)}

    before do
      expect(account).to receive(:google_auth_data).twice.and_return(google_auth_data)
      expect(HTTParty).to receive(:post).with(TokenRefresher::REFRESH_TOKEN_URL, subject.options).and_return(new_token)
      expect(account).to receive(:update_token!).with(parsed_response)
    end

    it 'retrieves a new token' do
      subject.refresh!
    end
  end
end
