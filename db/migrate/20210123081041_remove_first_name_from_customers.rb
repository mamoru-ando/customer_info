class RemoveFirstNameFromCustomers < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :first_name, :string
  end
end
