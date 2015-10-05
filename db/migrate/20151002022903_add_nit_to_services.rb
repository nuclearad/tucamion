class AddNitToServices < ActiveRecord::Migration
  def change
    add_column :services, :nit, :string, limit: 15, null: false, default: 'S/N' 
    add_column :services, :url_map, :string, limit: 500, default: '' 
  end
end