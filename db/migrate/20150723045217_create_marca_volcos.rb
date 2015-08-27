class CreateMarcaVolcos < ActiveRecord::Migration
  def change
    create_table :marca_volcos do |t|
      t.string :name

      t.timestamps
    end
  end
end
