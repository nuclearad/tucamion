class AddColummsTokenCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :token_active, :string, default: '', index: true
  end
end
