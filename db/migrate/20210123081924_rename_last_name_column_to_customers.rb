class RenameLastNameColumnToCustomers < ActiveRecord::Migration[6.0]
  def change
    rename_column :customers, :last_name, :name
  end
end
