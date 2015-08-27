class CreateReferencia < ActiveRecord::Migration
  def change
    create_table :referencia do |t|
      t.string :name

      t.timestamps
    end
  end
end
