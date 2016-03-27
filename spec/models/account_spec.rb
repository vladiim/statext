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

  describe '#google_data' do

    context 'token expired' do
      let(:google_auth_data) {{credentials: {expires_at: Time.now.to_i - 10}}.to_json}

      it "refreshes the user's token" do
        expect(subject).to receive(:google_auth_data).twice.and_return(google_auth_data)
        expect(subject).to receive(:refresh_token!).and_return('REFRESH TOKEN!')
        subject.google_data
      end
    end

    context 'token alive' do
      let(:google_auth_data) {{credentials: {expires_at: Time.now.to_i + 1000}}.to_json}

      it 'returns the google_auth_data' do
        expect(subject).to receive(:google_auth_data).twice.and_return(google_auth_data)
        expect(subject.google_data).to eq(google_auth_data)
      end
    end
  end

  describe '#update_token!(new_token)' do
    let(:new_token) {{"access_token"=>"ACCESS_TOKEN", "token_type"=>"Bearer", "expires_in"=>3600, "id_token"=>"ID_TOKEN"}}
    let(:google_auth_data) {{'credentials' => {'token' => 'OLD', 'expires_at' => 1234, 'access_token' => 'OLD ACCESS'}}.to_json}
    let(:updated_google_auth_data) { {"credentials"=>{"token"=>"OLD","expires_at"=>Time.new.to_i + 3600, "access_token"=>"ACCESS_TOKEN"}}.to_json}

    before do
      expect(subject).to receive(:google_auth_data).and_return(google_auth_data)
      expect(subject).to receive(:update).with(google_auth_data: updated_google_auth_data).and_return('UPDATED SUBJECT')
    end

    it 'updates the google_auth_data credentials' do
      expect(subject.update_token!(new_token)).to eq('UPDATED SUBJECT')
    end
  end

  describe '#all_reports' do
    let(:mock_report) {OpenStruct.new(generate: 'GA REPORTS')}
    before {expect(Report).to receive(:new).and_return(mock_report)}

    it 'generates the GA reports' do
      expect(subject.all_reports).to eq('GA REPORTS')
    end
  end

  describe '#authorised_token' do
    before {allow(subject).to receive(:google_auth_data).and_return(google_auth_data)}

    context 'current token is fresh' do
      let(:google_auth_data) {{"credentials" => {'token' => 'CURRENT TOKEN', "expires_at" => Time.new.to_i + 3600}}.to_json}

      it 'returns the current token' do
        expect(subject.authorised_token).to eq('CURRENT TOKEN')
      end
    end

    context 'current token is not fresh' do
      let(:google_auth_data) {{"credentials" => {'token' => 'CURRENT TOKEN', "expires_at" => Time.new.to_i - 1}}.to_json}
      before {expect(subject).to receive(:refresh_token!)}

      it 'updates the token' do
        expect(subject.authorised_token).to eq('CURRENT TOKEN')
      end
    end
  end
end
