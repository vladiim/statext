require 'spec_helper'
load "#{Dir.pwd}/spec/data/google_omni_auth.rb"

RSpec.describe Account do
  let(:auth) {GoogleOmniAuth.data}
  describe '.find_or_create_with_omniauth' do
    context 'account exsits' do
      it 'returns the account' do
        email = auth.fetch(:info).fetch(:email)
        expect(Account).to receive(:find).with(email: email).and_return('ACCOUNT')
        expect(Account.find_or_create_with_omniauth(auth)).to eq('ACCOUNT')
      end
    end

    context 'no account exsits' do
      it 'creates a new account' do
        expect(Account).to receive(:create_with_omniauth).with(auth).and_return('NEW ACCOUNT')
        expect(Account.find_or_create_with_omniauth(auth)).to eq('NEW ACCOUNT')
      end
    end
  end
end
