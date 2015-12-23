class CreateTypeTrucksExtras < ActiveRecord::Migration
  def change
  	remove_column :extras, :type_truck_id
    create_table :types_truck_extras do |t|
      t.references :extra, index: true,  null: false
      t.references :type_truck, index: true,  null: false
      t.timestamps
    end
  end
end