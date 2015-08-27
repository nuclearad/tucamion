class CreateSubTrucks < ActiveRecord::Migration
  def change
    create_table :sub_trucks do |t|
      t.string :name
      t.integer :type_trucks_id

      t.timestamps
    end
  end
end
