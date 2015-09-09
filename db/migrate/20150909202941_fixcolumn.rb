class Fixcolumn < ActiveRecord::Migration
  def change
    rename_column :trucks, :referecia_id, :referencia_id
  end

end
