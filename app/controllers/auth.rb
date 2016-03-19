Statext::App.controllers :auth do
  get ':provider/callback' do

    omniauth = request.env["omniauth.auth"]
    creds    = omniauth[:credentials]

    USER_ID = 'ga:66466136'

    service = Google::Apis::AnalyticsV3::AnalyticsService.new

    service.authorization = creds['token']

    # byebug

    content_type(:json)
    # service.get_ga_data('ga:64727307', '2015-01-01', '2016-02-01', 'ga:users', dimensions: 'ga:month,ga:year').rows.to_json


    service.list_account_summaries.items.map do |site|
      {
        name: site.name, id: site.id,
        web_properties: site.web_properties.map do |property|
          {
            name: property.name, id: property.id,
            profiles: property.profiles.map do |profile|
              {
                name: profile.name, id: profile.id
              }
            end
          }
        end
      }
    end.to_json
    # @user = User.find_uid(omniauth["uid"])
    # @user = User.new_from_omniauth(omniauth) if @user.nil?
  end

  # get :github_callback_failed, :map => "/auth/failure" do
  #   flash[:error] = "Error logging with github.com #{params[:message]}"
  #
  #   redirect url("/")
  # end
end
