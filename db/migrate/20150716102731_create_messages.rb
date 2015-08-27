class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :nombre
      t.string :telefono
      t.text :mensaje
      t.integer :tipo
      t.integer :item

      t.timestamps
    end
  end
end
