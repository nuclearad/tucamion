class AddEmailToExtras < ActiveRecord::Migration
  def change
    add_column :extras, :email, :string
  end
end
