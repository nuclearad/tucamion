class ChangeNameToBrands < ActiveRecord::Migration
  def change
    rename_column :brand_trucks, :type_id, :type_truck_id
  end
end
