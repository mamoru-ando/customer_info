class RemoveVisitFromCustomers < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :visit, :string
  end
end
