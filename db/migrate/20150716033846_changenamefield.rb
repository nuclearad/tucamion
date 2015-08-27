class Changenamefield < ActiveRecord::Migration
  def change
    rename_column :customers, :type, :typeuser
  end
end
