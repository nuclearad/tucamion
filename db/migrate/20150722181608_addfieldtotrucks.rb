class Addfieldtotrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :sub_truck_id, :integer
  end
end
