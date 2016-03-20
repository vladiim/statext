Statext::App.controllers :accounts do

  get :index do
    content_type :text
    current_account.to_yaml
  end

  get :destroy do
    set_current_account(nil)
    redirect '/'
  end
  # get ':provider/callback' do
  #   omniauth = request.env["omniauth.auth"]
  #   creds    = omniauth[:credentials]
  #   USER_ID = 'ga:66466136'
  #   service = Google::Apis::AnalyticsV3::AnalyticsService.new
  #   service.authorization = creds['token']
  #   content_type(:json)
  #   # service.get_ga_data('ga:64727307', '2015-01-01', '2016-02-01', 'ga:users', dimensions: 'ga:month,ga:year').rows.to_json
  #   service.list_account_summaries.items.map do |site|
  #     {
  #       name: site.name, id: site.id,
  #       web_properties: site.web_properties.map do |property|
  #         {
  #           name: property.name, id: property.id,
  #           profiles: property.profiles.map do |profile|
  #             {
  #               name: profile.name, id: profile.id
  #             }
  #           end
  #         }
  #       end
  #     }
  #   end.to_json
  #   # @user = User.find_uid(omniauth["uid"])
  #   # @user = User.new_from_omniauth(omniauth) if @user.nil?
  # end
end
