Statext::App.controllers :auth do
  get ':provider/callback' do
    omniauth = request.env['omniauth.auth']
    account = Account.find_or_create_with_omniauth(omniauth)
    set_current_account(account)
    redirect '/accounts'
  end
end
