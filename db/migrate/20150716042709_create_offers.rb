class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :nombre
      t.text :descripcion
      t.string :precio1
      t.string :precio2
      t.integer :trucks, default: 0
      t.integer :service, default: 0
      t.integer :extra, default: 0

      t.timestamps
    end
  end
end
