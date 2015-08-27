class AddEstadoToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :estado, :integer, :default => '1'
  end
end
