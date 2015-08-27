class AddColumnToBrands < ActiveRecord::Migration
  def change
    add_column :brand_trucks, :type_id, :integer
  end
end
