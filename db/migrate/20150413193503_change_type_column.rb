class ChangeTypeColumn < ActiveRecord::Migration
  def change
    change_column :services, :state, :integer
  end
end
