require 'spec_helper'

RSpec.describe Report do
  let(:account) {Object.new}
  let(:subject) {Report.new(account)}

  before {allow(account).to receive(:authorised_token).and_return('AUTH TOKEN')}

  describe '.new' do
    it 'stores the account' do
      expect(subject.account).to eq(account)
    end

    it 'stores a new analytics service' do
      expect(subject.service).to be_a(Google::Apis::AnalyticsV3::AnalyticsService)
    end
  end

  describe '#generate' do
    context 'no account reports' do
      let(:account) {OpenStruct.new(reports: nil)}
      let(:fake_service) {OpenStruct.new(list_account_summaries: list_account_summaries)}
      let(:new_report) {[{:nick_name => 'profile_name', :name=>"PROFILE NAME", :id=>"PROFILE ID", :site=>"ACCOUNT NAME", :property=>"WEB PROPERTY NAME"}]}
      let(:list_account_summaries) do
        OpenStruct.new(items: [OpenStruct.new(name: 'ACCOUNT NAME', web_properties: [OpenStruct.new(name: 'WEB PROPERTY NAME', profiles: [OpenStruct.new(name: 'PROFILE NAME', id: 'PROFILE ID')])])])
      end

      before do
        expect(subject).to receive(:service).and_return(fake_service)
        expect(account).to receive(:update_reports!).with(new_report)
      end

      it 'updates the account reports from GA' do
        subject.generate
      end
    end

    context 'account reports no new reports' do
      let(:account) {OpenStruct.new(reports: 'ACCOUNT REPORTS')}
      it 'returns the account report' do
        expect(subject.generate).to eq('ACCOUNT REPORTS')
      end
    end

    context 'account reports and new reports' do
      it 'updates with new reports'
    end
    context 'account reports deleted reports' do
      it 'removes the reports'
    end
  end
end
