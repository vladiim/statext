Statext::App.controllers :reports do
  get :index do
    content_type(:json)
    current_account.all_reports
  end
end
