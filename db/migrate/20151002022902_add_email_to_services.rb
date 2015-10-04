class AddEmailToServices < ActiveRecord::Migration
  def change
    add_column :services, :email, :string
  end
end
