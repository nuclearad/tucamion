class AddUrlFieldtoTrucksTables < ActiveRecord::Migration
  def change
    add_column :brand_trucks, :link_rewrite, :string
    add_column :type_trucks, :link_rewrite, :string
    add_column :cities, :link_rewrite, :string
    add_column :states, :link_rewrite, :string
  end
end
