Statext::App.controllers :accounts do

  get :index do
    haml :'accounts/index'
  end

  get :destroy do
    set_current_account(nil)
    redirect '/'
  end
end
