class RenameTrucks < ActiveRecord::Migration
  def change


    rename_column :trucks, :space_truck_id, :spaces_truck_id
    rename_column :trucks, :transmissions_truck_id, :transmissions_truck_id
    rename_column :trucks, :scrap_truck_id, :scraps_truck_id
    rename_column :trucks, :contract_truck_id, :contracts_truck_id
    rename_column :trucks, :box_truck_id, :boxes_truck_id
    rename_column :trucks, :motor_truck_id, :motors_truck_id

  end
end
