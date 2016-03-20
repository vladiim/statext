require 'spec_helper'

RSpec.describe "/google_analytics_profiles" do
  describe 'GET' do
    before do
      get '/google_analytics_profiles', {'Content-Type' => 'application/json'}
    end

    it "returns the current user's Google Analytics Profiles" do
      expect(last_response.body).to eq [{name: "blah"}].to_json
    end
  end
end
