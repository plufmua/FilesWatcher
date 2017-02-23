class CreateDataSets < ActiveRecord::Migration[5.0]
  def change
    create_table :data_sets do |t|
      t.string   :name, null: false
      t.bigint   :size, null: false
      t.string   :absolute_path, null: false
      t.datetime :creation_time, null: false
      t.datetime :updating_time, null: false
      t.string   :owner, null: false
      t.string   :group, null: false
      t.integer  :permissions, null: false

      t.timestamps
    end
  end
end
