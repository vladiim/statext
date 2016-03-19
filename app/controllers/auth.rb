Statext::App.controllers :auth do

  post :create do
    request.session['user_email'] = user_email = params.fetch('email') {'No email received!'}
    redirect GoogleAuth.get_authorization_url(user_email, request)
  end

  get :callback do
    redirect GoogleAuth.handle_auth_callback_deferred(request)
  end
end
