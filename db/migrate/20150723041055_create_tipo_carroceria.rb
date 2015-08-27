class CreateTipoCarroceria < ActiveRecord::Migration
  def change
    create_table :tipo_carroceria do |t|
      t.string :name

      t.timestamps
    end
  end
end
