class AddrtypeTruckId < ActiveRecord::Migration
  def change
    rename_table :referencia, :referencias
    add_column :referencias, :type_truck_id, :integer
  end
end
