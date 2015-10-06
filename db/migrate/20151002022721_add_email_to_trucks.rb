class AddEmailToTrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :email, :string
  end
end
