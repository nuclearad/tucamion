class AddTypeCardToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :type_card, :string, limit: 15, null: false, default: ''
  end
end