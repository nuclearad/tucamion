class CreateTrucks < ActiveRecord::Migration
  def change
    create_table :trucks do |t|
      t.string :nombre
      t.string :modelo
      t.string :ubicacion
      t.string :kilometraje
      t.integer :estado
      t.string :placa
      t.string :ubicacionplaca
      t.string :color
      t.string :tipocombustible
      t.string :marcamotor
      t.string :marcacaja
      t.string :marcatransmision
      t.boolean :quintarueda
      t.string :tipocupo
      t.string :empresaafiliada
      t.string :marcacarpa
      t.string :capacidadcarga
      t.string :capacidadpasajeros
      t.string :cilindrajecc
      t.string :numeroejes
      t.boolean :trailer
      t.boolean :negociable
      t.string :estadollantas
      t.boolean :vigia
      t.integer :tipodecaja
      t.boolean :motorreparado
      t.boolean :cajareparada
      t.boolean :transmisionreparada
      t.boolean :frenosabs
      t.boolean :cupo
      t.boolean :sillareclinable
      t.boolean :bano
      t.boolean :descansapies
      t.boolean :tv
      t.boolean :pantallaindividual
      t.boolean :wifi
      t.boolean :audio
      t.boolean :unicodueno
      t.belongs_to :brand_truck
      t.belongs_to :type_truck

      t.text :descripcion

      t.timestamps
    end
  end
end
