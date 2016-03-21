require 'spec_helper'

RSpec.describe Report do
  let(:account) {Object.new}
  let(:subject) {Report.new(account)}

  describe '.new' do
    it 'stores the account' do
      expect(subject.account).to eq(account)
    end
  end

  describe '#generate' do
    let(:list_account_summaries) do
      OpenStruct.new(items:
        [{
          name: 'ACCOUNT NAME',
          web_properties: [{
            name: 'WEB PROPERTY NAME',
            profiles: [{
              name: 'PROFILE NAME',
              id: 'PROFILE ID'
        }]}]}])

      context 'no account reports' do
        it 'updates the account reports from GA' do
        end
      end
      context 'account reports no new reports' do
      end
      context 'account reports and new reports' do
      end
      context 'account reports deleted reports' do
      end
    end
  end
end
