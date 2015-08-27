class AddColumnstoTruck < ActiveRecord::Migration
  def change
    add_column :trucks, :state_id, :integer
    add_column :trucks, :city_id, :integer
  end
end
