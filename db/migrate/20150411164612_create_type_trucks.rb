class CreateTypeTrucks < ActiveRecord::Migration
  def change
    create_table :type_trucks do |t|
      t.string :name

      t.timestamps
    end
  end
end
