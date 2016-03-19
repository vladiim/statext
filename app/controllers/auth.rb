Statext::App.controllers :auth do
  get ':provider/callback' do
    'google_oauth2'
    # omniauth = request.env["omniauth.auth"]
    #
    # @user = User.find_uid(omniauth["uid"])
    # @user = User.new_from_omniauth(omniauth) if @user.nil?
  end

  # get :github_callback_failed, :map => "/auth/failure" do
  #   flash[:error] = "Error logging with github.com #{params[:message]}"
  #
  #   redirect url("/")
  # end
end
