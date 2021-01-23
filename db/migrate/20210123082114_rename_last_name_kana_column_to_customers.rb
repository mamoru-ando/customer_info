class RenameLastNameKanaColumnToCustomers < ActiveRecord::Migration[6.0]
  def change
    rename_column :customers, :last_name_kana, :name_kana
  end
end
