Sequel.migration do
  up do
    alter_table :accounts do
      add_column :reports, :jsonb
    end
  end

  down do
    alter_table :accounts do
      drop_column :reports
    end
  end
end
