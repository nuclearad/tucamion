class AddColummsIds < ActiveRecord::Migration
  def change
    add_column :trucks,   :user_id, :integer, default: 0, index: true
    add_column :extras,   :user_id, :integer, default: 0, index: true
    add_column :services, :user_id, :integer, default: 0, index: true
    add_column :messages, :user_id, :integer, default: 0, index: true
    add_column :messages, :customer_id, :integer, default: 0, index: true
    add_column :messages, :status, :integer, default: 1
  end
end
