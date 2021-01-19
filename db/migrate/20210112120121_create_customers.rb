class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :last_name,     null: false
      t.string :first_name,    null: false
      t.string :last_name_kana
      t.string :first_name_kana
      t.integer :sex_id
      t.string :tell1
      t.string :tell2
      t.string :email
      t.string :address
      t.string :visit
      t.text :memo
      t.text :appearance
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
