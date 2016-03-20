require 'spec_helper'

RSpec.describe GoogleAnalyticsProfile do
  let(:user) {Object.new}
  let(:subject) {described_class.new(user)}
  describe '.new' do
    it 'remembers the user' do
      expect(subject.user).to eq user
    end
  end

  describe '#all' do
    context 'request token' do
    end
    it "returns the user's GA profiles" do

    end
  end
end
