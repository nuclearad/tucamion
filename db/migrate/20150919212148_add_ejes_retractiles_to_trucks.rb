class AddEjesRetractilesToTrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :ejesretractiles ,:integer, default: 0
  end
end
