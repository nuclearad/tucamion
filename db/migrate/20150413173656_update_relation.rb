class UpdateRelation < ActiveRecord::Migration
  def change
    remove_column :extras, :type_extra_id
    add_column :extras, :type_truck_id, :integer
  end
end
