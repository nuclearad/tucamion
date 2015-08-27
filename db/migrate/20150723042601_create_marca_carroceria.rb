class CreateMarcaCarroceria < ActiveRecord::Migration
  def change
    create_table :marca_carroceria do |t|
      t.string :name

      t.timestamps
    end
  end
end
