class CreateApprearances < ActiveRecord::Migration[6.0]
  def change
    create_table :apprearances do |t|

      t.timestamps
    end
  end
end
