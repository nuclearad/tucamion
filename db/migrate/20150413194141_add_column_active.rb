class AddColumnActive < ActiveRecord::Migration
  def change
    add_column :trucks, :active, :integer, :default => 1
    add_column :extras, :active, :integer, :default => 1
  end
end
