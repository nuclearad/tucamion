class AddNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, limit: 20, null: false
    add_column :users, :last_name, :string, limit: 20, null: false
  end
end
