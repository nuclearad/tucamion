class AddPhoneToTrucks < ActiveRecord::Migration
  def change
    add_column :trucks, :phone, :string
  end
end
