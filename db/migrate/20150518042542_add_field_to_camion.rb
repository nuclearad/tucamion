class AddFieldToCamion < ActiveRecord::Migration
  def change
    add_column :trucks, :wheel_truck_id, :integer
    add_column :trucks, :color_truck_id, :integer
    add_column :trucks, :space_truck_id, :integer
    add_column :trucks, :transmissions_truck_id, :integer
    add_column :trucks, :scrap_truck_id, :integer
    add_column :trucks, :contract_truck_id, :integer
    add_column :trucks, :box_truck_id, :integer
    add_column :trucks, :motor_truck_id, :integer

    rename_column :trucks,  :wheel_truck_id, :wheels_truck_id

  end
end
