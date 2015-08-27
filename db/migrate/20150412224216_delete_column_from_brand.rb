class DeleteColumnFromBrand < ActiveRecord::Migration
  def change
    remove_column :brand_trucks, :type_truck_id
  end
end
