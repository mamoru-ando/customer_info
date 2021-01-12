class CreateApprearances < ActiveRecord::Migration[6.0]
  def change
    create_table :apprearances do |t|
      t.text :text
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
