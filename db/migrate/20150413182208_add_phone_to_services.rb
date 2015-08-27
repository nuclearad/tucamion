class AddPhoneToServices < ActiveRecord::Migration
  def change
    add_column :services, :phone, :string
  end
end
