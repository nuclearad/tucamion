class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :cedula
      t.string :telefono
      t.string :email
      t.string :clave
      t.integer :type

      t.timestamps
    end
  end
end
