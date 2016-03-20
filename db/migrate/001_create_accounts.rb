Sequel.migration do
  up do
    create_table :accounts do
      primary_key :id
      String  :first_name
      String  :last_name
      String  :email
      String  :role
      Jsonb   :google_auth_data
    end
  end

  down do
    drop_table :accounts
  end
end
