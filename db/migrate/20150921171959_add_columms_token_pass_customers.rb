class AddColummsTokenPassCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :token_pass, :string, default: '', index: true
  end
end
