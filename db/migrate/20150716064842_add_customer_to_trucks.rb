class AddCustomerToTrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :customer_id, :integer
    add_column :extras, :customer_id, :integer
    add_column :services, :customer_id, :integer

  end
end
