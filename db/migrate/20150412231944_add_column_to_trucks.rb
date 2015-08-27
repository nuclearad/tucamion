class AddColumnToTrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :link_rewrite, :string
  end
end
