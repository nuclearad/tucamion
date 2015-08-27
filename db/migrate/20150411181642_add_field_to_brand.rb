class AddFieldToBrand < ActiveRecord::Migration
  def change
    add_column :brand_trucks, :name, :string
  end
end
