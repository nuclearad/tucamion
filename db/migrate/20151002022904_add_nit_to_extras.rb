class AddNitToExtras < ActiveRecord::Migration
  def change
  	remove_column :extras, :price
    add_column :extras, :nit, :string, limit: 15, null: false, default: 'S/N' 
    add_column :extras, :url_map, :string, limit: 500, default: '' 
  end
end