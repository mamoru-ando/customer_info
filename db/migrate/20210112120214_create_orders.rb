class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.date :date,      null: false
      t.integer :people, null: false
      t.string :table,   null: false
      t.string :drink
      t.string :food
      t.integer :pay,    null: false
      t.text :order_memo
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
