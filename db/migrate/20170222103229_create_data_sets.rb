class CreateDataSets < ActiveRecord::Migration[5.0]
  def change
    create_table :data_sets do |t|
      t.string :name, null: false
      t.string :size, null: false
      t.string :route, null: false
      t.datetime :creating_date, null: false
      t.datetime :updating_date, null: false
      t.string :owner, null: false
      t.string :group, null: false
      t.integer :permissions, null: false

      t.timestamps
    end
  end
end
