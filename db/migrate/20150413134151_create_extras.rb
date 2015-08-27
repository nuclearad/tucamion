class CreateExtras < ActiveRecord::Migration
  def change
    create_table :extras do |t|
      t.string :name
      t.float :price
      t.string :address
      t.belongs_to :state
      t.belongs_to :city
      t.string :phone
      t.string :horario
      t.text :description
      t.belongs_to :type_extra
      t.belongs_to :brand_extra
      t.string :link_rewrite


      t.timestamps
    end
  end
end
