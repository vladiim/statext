require 'google/apis/analytics_v3'

class Report
  attr_reader :account, :service
  def initialize(account)
    @account = account
    init_authorised_service
  end

  def generate
    reports = account.reports
    generate_new_reports if reports.nil?
    reports
  end

  private

  def init_authorised_service
    @service = Google::Apis::AnalyticsV3::AnalyticsService.new
    service.authorization = account.authorised_token
  end

  def generate_new_reports
    account.update_reports!(new_reports)
  end

  def new_reports
    service.list_account_summaries.items.map do |site|
      site.web_properties.map do |property|
        property.profiles.map do |profile|
          report_item(profile, site, property)
        end
      end
    end.flatten
  end

  def report_item(profile, site, property)
    {
      nick_name: profile.name.downcase.gsub(' ', '_'),
      name: profile.name,
      id: profile.id,
      site: site.name,
      property: property.name
    }
  end
end
