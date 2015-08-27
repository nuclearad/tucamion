class ChangeNameState < ActiveRecord::Migration
  def change
    rename_column :services, :state, :active
  end
end
