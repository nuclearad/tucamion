class RenameField < ActiveRecord::Migration
  def change
    rename_column :cities, :states_id, :state_id
  end
end
