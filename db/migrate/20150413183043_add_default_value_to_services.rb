class AddDefaultValueToServices < ActiveRecord::Migration
  def change
    change_column :services, :state, :boolean, :default => true
  end
end
