Statext::App.controllers :home do
  get :index do
    haml :'home/index'
  end
end
