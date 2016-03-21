require 'spec_helper'

RSpec.describe "/reports" do
  describe 'GET' do
    let(:account) {OpenStruct.new(all_reports: 'ALL REPORTS')}
    before do
      expect_any_instance_of(Statext::App).to receive(:current_account).twice.and_return(account)
      get '/reports', {'Content-Type' => 'application/json'}
    end

    it "returns the current user's reports" do
      expect(last_response.body).to eq("\"ALL REPORTS\"")
    end
  end
end
