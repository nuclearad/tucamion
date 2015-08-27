class CreateMarcaEquipoHumedos < ActiveRecord::Migration
  def change
    create_table :marca_equipo_humedos do |t|
      t.string :name

      t.timestamps
    end
  end
end
