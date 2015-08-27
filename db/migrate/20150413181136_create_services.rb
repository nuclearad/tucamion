class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :link_rewrite
      t.belongs_to :state
      t.belongs_to :city
      t.belongs_to :type_service
      t.string :horario
      t.string :address
      t.boolean :state
      t.text :description

      t.timestamps
    end
  end
end
